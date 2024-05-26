//
// Created by John Griffin on 4/18/24
//

import ColorPalette
import SwiftUI

#if os(visionOS)

    #Preview {
        RealityUIView {
            ScaledGrid3D(
                domain: Rect3D(origin: .zero, size: .one * 4),
                gridScaleFor: .uniformFit(padding: .one * 0.1)
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

#endif
