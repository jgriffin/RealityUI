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
        RealityUIView {
            Stack3D(axis: .up, spacing: 0.01) {
                Line3D()
                Line3D()
            }
        }
    }

#endif
