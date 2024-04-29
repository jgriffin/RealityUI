//
// Created by John Griffin on 4/18/24
//

import SwiftUI

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            Stack3D(.right, alignment: .center, spacing: .zero) {
                Sphere3D()
                Box3D()
                Sphere3D()
                    .offset(y: -0.1)
            }
            .padding(.init(0.1))
        }
    }

    #Preview {
        RealityUIView {
            Box3D()
                .padding(.init(0.01))
        }
    }

#endif
