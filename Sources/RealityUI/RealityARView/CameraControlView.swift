//
// Created by John Griffin on 6/2/24
//

import simd
import Spatial
import SwiftUI

#if !os(visionOS)

    struct CameraControlView: View {
        let camera: CameraHolder
        @State private var mode: Mode = .orbit

        enum Mode {
            case interact, move, orbit, radius
        }

        @GestureState private var originalModel: CameraModel?

        var body: some View {
            GeometryReader { proxy in
                Color.clear
                    .contentShape(Rectangle())
                    .gesture(cameraDragGesture(proxy.size))
                    .simultaneousGesture(cameraZoomGesture)
                    .coordinateSpace(.named("CameraControlView"))
                    .overlay(alignment: .bottomLeading) { modeBar }
                    .padding()
            }
        }

        // MARK: - mode bar

        var modeBar: some View {
            HStack {
                button(.interact, "cursorarrow")
                button(.move, "arrow.up.and.down.and.arrow.left.and.right")
                button(.orbit, "rotate.3d")
                button(.radius, "arrow.up.left.and.down.right.magnifyingglass")
                Button(action: { camera.cameraModel = .init() }) {
                    Image(systemName: "scope")
                }
            }
            .buttonStyle(.accessoryBar)
            .padding(5)
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 5)
            )
        }

        func button(_ forMode: Mode, _ image: String) -> some View {
            Button(action: { mode = forMode }) {
                Image(systemName: image)
                    .foregroundColor(mode == forMode ? .blue : nil)
            }
        }

        // MARK: - gesture

        func handleDrag(startRatio: CGPoint, endRatio: CGPoint, original: CameraModel) {
            switch mode {
            case .interact:
                break
            case .move:
                let deltaX = endRatio.x - startRatio.y
                let deltaY = endRatio.y - startRatio.y

                let speed: Double = 5
                let offset = Vector3D(x: deltaX * speed, y: deltaY * speed, z: 0)

                let lookRotation = Vector3D(x: 0, y: 0, z: 1).rotation(to: original.direction)
                let rotatedOffset = offset.rotated(by: lookRotation)

                let lookAtPoint = original.lookAtPoint - rotatedOffset
                camera.cameraModel.lookAtPoint = lookAtPoint

            case .orbit:
                let start = ndcPoint(ratioPoint: startRatio)
                let end = ndcPoint(ratioPoint: endRatio)
                let rotation = end.rotation(to: start)

                let direction = (original.direction).rotated(by: rotation)
                camera.cameraModel.direction = direction

            case .radius:
                let deltaX = endRatio.x - startRatio.y
                let deltaY = endRatio.y - startRatio.y

                let speed: Double = 2
                let magnification = (deltaX + deltaY) * speed
                let radius = original.radius / max(0.1, min(1 + magnification, 10))

                camera.cameraModel.radius = max(1, radius)
            }
        }

        func cameraDragGesture(_ viewSize: CGSize) -> some Gesture {
            DragGesture(coordinateSpace: .named("CameraControlView"))
                .updating($originalModel) { value, state, _ in
                    guard let original = state else {
                        state = camera.cameraModel
                        return
                    }
                    let startRatio = ratioPoint(value.startLocation, viewSize: viewSize)
                    let endRatio = ratioPoint(value.location, viewSize: viewSize)

                    handleDrag(startRatio: startRatio, endRatio: endRatio, original: original)
                }
        }

        var cameraZoomGesture: some Gesture {
            MagnifyGesture()
                .updating($originalModel) { value, state, _ in
                    guard let original = state else {
                        state = camera.cameraModel
                        return
                    }

                    camera.cameraModel.radius = original.radius / max(0.1, min(abs(value.magnification), 10))
                }
        }

        /// normalized  0 ... 1
        func ratioPoint(_ point: CGPoint, viewSize: CGSize) -> CGPoint {
            CGPoint(
                x: point.x / viewSize.width,
                y: 1 - point.y / viewSize.height
            )
        }

        /// normalized device coordinates: -1 ... 1
        func ndcPoint(ratioPoint: CGPoint) -> Vector3D {
            var ndc = Vector3D(
                x: 2 * ratioPoint.x - 1,
                y: 2 * ratioPoint.y - 1,
                z: 0.001
            )
            if (ndc.x * ndc.x + ndc.y * ndc.y) <= 1 {
                ndc.z = sqrt(max(0.001, 1 - ndc.length))
            }
            return ndc.normalized
        }
    }

#endif
