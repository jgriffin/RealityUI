//
// Created by John Griffin on 4/18/24
//

import ColorPalette
import Spatial
import SwiftUI

#Preview {
    RealityUIView {
        Stack3D(axis: .right, alignment: .center, spacing: .one * 0.01) {
            Sphere3D()
            Box3D()

            Sphere3D()
                .offset(y: -0.1)
            Cylinder3D()
        }
        .padding(.init(0.1))
    }
}

// #Preview {
//    RealityUIView {
//        Stack3D(axis: .up) {
//            Box3D()
//                .padding(.init(back: 0.25 / 2))
//                .frame(size: .init(width: 0.4, height: 0.1, depth: 0.25))
//                .foreground(.color(.css(basic: .fuchsia)))
//            Cone3D()
//                .foreground(.color(.css(basic: .lime)))
//                .frame(size: .init(width: 0.25, height: 0.5, depth: 0.25))
//        }
//    }
// }
