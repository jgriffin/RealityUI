//
// Created by John Griffin on 4/18/24
//

import SwiftUI

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            LayoutView3D(.stacked(axis: .right, alignment: .center, spacing: .one * 0.01)) {
                Sphere3D()
                Box3D()
                Sphere3D()
                    .offset(y: -0.1)
                Cylinder3D()
            }
            .padding(.init(0.1))
        }
    }

    #Preview {
        let linePoints = [
            Vector3D.bottomLeadingFront, .bottomTrailingFront, .topTrailingFront, .topLeadingFront,
            .topLeadingBack, .topTrailingBack, .bottomTrailingBack, .bottomLeadingBack,
            .bottomLeadingFront,
        ].map { Point3D($0 * 0.2) }

        return RealityUIView {
            LayoutView3D(.canvas()) {
                Line3D(linePoints)
            }
        }
    }

    #Preview {
        RealityUIView {
            LayoutView3D(.stacked(axis: .right, spacing: .one * 0.03)) {
                ForEach3D([0, 1, 2], id: \.self) { _ in
                    Box3D()
                        .aspectRatio(.one)
                }
            }
        }
    }

#endif
