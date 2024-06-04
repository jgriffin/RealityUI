//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial
import SwiftUI

public struct RealityUIView: View {
    var view3D: any View3D
    @State private var renderer = RealityUIRenderer()

    public init(@View3DBuilder _ view3D: () -> some View3D) {
        self.view3D = view3D()
    }

    #if os(visionOS)

        public var body: some View {
            GeometryReader3D { proxy in
                let localFrame = proxy.frame(in: .local)

                RealityView { content in
                    content.add(renderer.realityRoot)

                    let sceneBounds = content.convert(localFrame, from: .local, to: .scene)
                    renderer.update(with: view3D, size: Size3D(sceneBounds.extents))
                } update: { content in
                    let sceneBounds = content.convert(localFrame, from: .local, to: .scene)
                    renderer.update(with: view3D, size: Size3D(sceneBounds.extents))
                }
            }
        }

    #else

        @State private var scale: Size3D = .one

        public var body: some View {
            GeometryReader { _ in
                RealityARView(
                    setupScene: { scene in
                        let anchor = AnchorEntity(world: .zero)
                        anchor.addChild(renderer.realityRoot)
                        scene.anchors.append(anchor)

                        renderer.setScale(4)
                        renderer.update(with: view3D, size: defaultVolumeSize)
                    }
                ) { _ in
                    renderer.update(with: view3D, size: defaultVolumeSize)
                }
                .edgesIgnoringSafeArea(.all)
            }
        }

        var defaultVolumeSize: Size3D {
            .init(width: 0.94117648, height: 0.5294118, depth: 0.3970588)
        }

    #endif
}
