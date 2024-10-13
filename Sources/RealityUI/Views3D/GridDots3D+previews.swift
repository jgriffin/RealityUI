//
// Created by John Griffin on 5/23/24
//

import Spatial
import SwiftUI

#Preview {
    RealityView3D {
        Geometry3DReader { size in
            let gridScale = DomainScaleFor.uniformFit(
                domain: Rect3D(center: .zero, size: .one * 2),
                domainPadding: .zero,
                size: size
            )
            GridDots3D(gridScale: gridScale)
        }
        .border()
    }
}
