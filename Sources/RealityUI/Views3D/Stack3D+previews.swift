//
// Created by John Griffin on 5/27/24
//

import SwiftUI

#if os(visionOS)

    #Preview("Alignment center") {
        RealityUIView {
            Stack3D {
                Box3D()
                    .frame(size: .one * 0.1)

                Box3D()
                    .frame(size: .one * 0.1)
                    .scale(.one * 0.5)
                    .offset(.init(x: -0.2, y: 0, z: 0))

                Sphere3D()
                    .frame(size: 0.1)
                    .offset(.init(x: 0.2, y: 0, z: 0))
            }
            .foreground(.cyan20)
            .border()
            .frame(size: 0.2)
        }
    }

#endif
