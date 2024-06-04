//
// Created by John Griffin on 6/2/24
//

import simd
import Spatial
import SwiftUI

#if !os(visionOS)

    struct CameraControlView: View {
        let camera: CameraHolder
        @State private var mode: Mode = .arc

        enum Mode {
            case interact, move, orbit, radius, arc
        }

        @GestureState private var originalModel: CameraModel?

        var body: some View {
            GeometryReader { proxy in
                Color.clear
                    .contentShape(Rectangle())
                    .gesture(cameraDragGesture(proxy.size))
                    .simultaneousGesture(cameraZoomGesture)
                    .coordinateSpace(.named("ArcBallView"))
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
                button(.arc, "rotate.3d.circle")
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
                break

            case .orbit:
                let deltaX = endRatio.x - startRatio.y
                let deltaY = endRatio.y - startRatio.y

                let euler = EulerAngles(
                    x: .zero,
                    y: .degrees(-deltaX * 180),
                    z: .degrees(-deltaY * 180),
                    order: .xyz
                )
                let rotation = Rotation3D(eulerAngles: euler)
                let direction = original.direction.rotated(by: rotation.quaternion)

//            let rotFromX = Rotation3D(angle: .degrees(-deltaX * 180), axis: .y)
//            let rotFromY = Rotation3D(angle: .degrees(deltaY * 180), axis: .x)
//            let direction = original.direction
//                .rotated(by: rotFromX.quaternion)
//                .rotated(by: rotFromY.quaternion)

                camera.cameraModel.direction = direction

            case .radius:
                let deltaX = endRatio.x - startRatio.y
                let deltaY = endRatio.y - startRatio.y

                let speed: Double = 2
                let magnification = (deltaX + deltaY) * speed
                let radius = original.radius / max(0.1, min(1 + magnification, 10))

                camera.cameraModel.radius = max(1, radius)

            case .arc:
                let start = ndcPoint(ratioPoint: startRatio)
                let end = ndcPoint(ratioPoint: endRatio)

//                let ndcToCamera = original.direction.rotation(to: .init(x: 0, y: 0, z: 1)).inverse
//                let startCamera = start.rotated(by: ndcToCamera)
//                let endCamera = end.rotated(by: ndcToCamera)
//                let rotation = endCamera.rotation(to: startCamera)

                let rotation = end.rotation(to: start)

                let direction = (original.direction).rotated(by: rotation)
                camera.cameraModel.direction = direction
            }
        }

        func cameraDragGesture(_ viewSize: CGSize) -> some Gesture {
            DragGesture(coordinateSpace: .named("ArcBallView"))
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
