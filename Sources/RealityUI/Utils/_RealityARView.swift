//
// Created by John Griffin on 6/1/24
//

#if !os(visionOS)

    import RealityKit
    import SwiftUI

    struct _RealityARView: View {
        let setupScene: (RealityKit.Scene) -> Void
        let update: (RealityKit.ARView) -> Void

        @State var arView: ARView = {
            let arv = ARView()
            #if os(iOS)
                arv.cameraMode = .nonAR
                arv.environment.background = .color(.white)
            #endif
            return arv
        }()

        @State var cameraAnchor = AnchorEntity(world: .zero)

        var body: some View {
            _ARViewRepresentable(
                arView: arView,
                setupScene: innerSetupScene,
                update: update
            )
            .overlay(
                _ArcBallView(
                    getCameraPosition: getCameraPosition,
                    setCameraPosition: setCameraPosition
                )
            )
        }

        // MARK: - setup

        func innerSetupScene(_ scene: RealityKit.Scene) {
            setupCamera(scene)
            setupScene(scene)
        }

        // MARK: - camera

        func setupCamera(_ scene: RealityKit.Scene) {
            let cameraEntity = PerspectiveCamera()
            cameraEntity.camera.fieldOfViewInDegrees = 60
            cameraAnchor.addChild(cameraEntity)
            scene.addAnchor(cameraAnchor)

            setCameraPosition([-1, 1, 3])
        }

        func getCameraPosition() -> SIMD3<Float> {
            cameraAnchor.position
        }

        func setCameraPosition(_ position: SIMD3<Float>) {
            cameraAnchor.position = position
            cameraAnchor.look(at: .zero, from: cameraAnchor.transform.translation, relativeTo: nil)
        }
    }

#endif
