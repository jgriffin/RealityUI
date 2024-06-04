//
// Created by John Griffin on 4/18/24
//

import ColorPalette
import Spatial
import SwiftUI

#Preview {
    RealityUIView {
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
}
