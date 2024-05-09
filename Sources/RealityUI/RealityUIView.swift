//
// Created by John Griffin on 4/18/24
//

#if os(visionOS)
    import RealityKit
    import SwiftUI

    public struct RealityUIView: View {
        var view3D: any View3D

        public init(_ view3D: () -> some View3D) {
            self.view3D = view3D()
        }

        @State private var renderer = RealityUIRenderer()

        public var body: some View {
            GeometryReader3D { proxy in
                RealityView { chartBody in
                    chartBody.add(renderer.realityRoot)

                    let sceneBounds = chartBody.convert(proxy.frame(in: .local), from: .local, to: .scene)
                    renderer.update(with: view3D, size: Size3D(sceneBounds.extents))
                } update: { chartBody in
                    let sceneBounds = chartBody.convert(proxy.frame(in: .local), from: .local, to: .scene)
                    renderer.update(with: view3D, size: Size3D(sceneBounds.extents))
                }
            }
        }
    }

    #Preview(windowStyle: .volumetric) {
        RealityUIView { Sphere3D() }
    }
#endif
