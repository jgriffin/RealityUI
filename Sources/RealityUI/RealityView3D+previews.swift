//
// Created by John Griffin on 4/18/24
//

import ColorPalette
import Spatial
import SwiftUI

#Preview("Box") {
    RealityView3D {
        Box3D()
            .foreground(.cyan20)
    }
}

#Preview("Stack") {
    RealityView3D {
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

#Preview("GridDots") {
    RealityView3D {
        DomainView3D(
            domain: Rect3D(origin: .zero, size: .one * 4)
        ) {
//                Canvas3D {
            Box3D()
                .frame(size: .one)
                .offset(.init(x: 1, y: 1, z: 1))
                //
                //                Box3D()
                //                    .frame(size: .one)
                //                    .offset(.init(x: 9, y: 9, z: 9))
//                }
                .foreground(.cyan20)
        } overlay: { gridScale in
            GridDots3D(gridScale: gridScale)
        }
    }
    .background(.black)
}
