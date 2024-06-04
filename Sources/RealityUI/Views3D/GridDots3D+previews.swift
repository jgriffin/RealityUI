//
// Created by John Griffin on 5/23/24
//

import Spatial
import SwiftUI

#Preview {
    RealityUIView {
        Geometry3DReader { size in
            let gridScale = DomainScaleFor.uniformFit()(
                domain: Rect3D(center: .zero, size: .one * 2),
                size: size
            )
//                Box3D()
//                    .frame(size: gridScale.bounds.size)
            GridDots3D(gridScale: gridScale)
        }
        .border()
    }
}
