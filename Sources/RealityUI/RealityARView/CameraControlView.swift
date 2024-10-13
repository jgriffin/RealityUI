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
            .foregroundColor(.primary.opacity(0.8))
            .buttonStyle(.plain)
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

        func handleDrag(startLocation: CGPoint, endLocation: CGPoint, original: CameraModel) {
            switch mode {
            case .interact:
                break

            case .move:
                guard let startLook = camera.lookPoint(startLocation),
                      let endLook = camera.lookPoint(endLocation)
                else {
                    return
                }

                let offset = (endLook - startLook)
                let lookAtPoint = original.lookAtPoint - offset
                camera.cameraModel.lookAtPoint = lookAtPoint

            case .orbit:
                let startRatio = camera.ratioPoint(startLocation)
                let endRatio = camera.ratioPoint(endLocation)
                let start = camera.ndcPoint(ratioPoint: startRatio)
                let end = camera.ndcPoint(ratioPoint: endRatio)
                let rotation = end.rotation(to: start)

                let direction = (original.direction).rotated(by: rotation)
                camera.cameraModel.direction = direction

            case .radius:
                let startRatio = camera.ratioPoint(startLocation)
                let endRatio = camera.ratioPoint(endLocation)
                let deltaX = endRatio.x - startRatio.y
                let deltaY = endRatio.y - startRatio.y

                let speed: Double = 2
                let magnification = (deltaX + deltaY) * speed
                let radius = original.radius / max(0.1, min(1 + magnification, 100))

                camera.cameraModel.radius = max(1, radius)
            }
        }

        func cameraDragGesture(_: CGSize) -> some Gesture {
            DragGesture(coordinateSpace: .named("CameraControlView"))
                .updating($originalModel) { value, state, _ in
                    guard let original = state else {
                        state = camera.cameraModel
                        return
                    }

                    handleDrag(
                        startLocation: value.startLocation,
                        endLocation: value.location,
                        original: original
                    )
                }
        }

        var cameraZoomGesture: some Gesture {
            MagnifyGesture()
                .updating($originalModel) { value, state, _ in
                    guard let original = state else {
                        state = camera.cameraModel
                        return
                    }

                    camera.cameraModel.radius = original.radius / max(0.1, min(abs(value.magnification), 100))
                }
        }
    }

#endif
