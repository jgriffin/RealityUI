//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial
import SwiftUI

public struct RealityView3D: View {
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

        @State var cameraControls: CameraControls = .orbit

        public var body: some View {
            GeometryReader { proxy in
                let defaultVolume = defaultVolumeForAspectRatio(proxy)

                RealityView { content in
                    content.add(renderer.realityRoot)
                    renderer.update(with: view3D, size: defaultVolume)
                } update: { _ in
                    renderer.update(with: view3D, size: defaultVolume)
                }
            }
            .environment(\.realityViewCameraControls, cameraControls)
            .overlay(alignment: .bottomLeading) {
                CameraControlsPicker(cameraControls: $cameraControls)
                    .padding(5)
            }
        }

        /// picks a 1-2 meter volume that fits into the window aspect ratio
        /// the ideal width is ~1m and the height must be less than ~2m
        func defaultVolumeForAspectRatio(_ proxy: GeometryProxy) -> Size3D {
            let fitFactor: CGFloat = 0.8
            let depthFactor: CGFloat = 0.75

            let size = proxy.size
            let aspectRatio = size.width / size.height

            if aspectRatio >= 1 {
                let width = 2 * fitFactor
                return Size3D(width: width, height: width / aspectRatio, depth: width * depthFactor)
            } else {
                let height = 2 * fitFactor
                return Size3D(width: height * aspectRatio, height: height, depth: height * depthFactor)
            }
        }

    #endif
}
