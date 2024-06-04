//
// Created by John Griffin on 6/1/24
//

#if !os(visionOS)

    import RealityKit
    import SwiftUI

    struct RealityARView: View {
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

        @State private var camera = CameraHolder()

        var body: some View {
            ARViewRepresentable(
                arView: arView,
                setupScene: innerSetupScene,
                update: update
            )
            .overlay(
                CameraControlView(camera: camera)
            )
        }

        // MARK: - setup

        func innerSetupScene(_ scene: RealityKit.Scene) {
            camera.addToScene(scene)
            setupScene(scene)
        }
    }

#endif
