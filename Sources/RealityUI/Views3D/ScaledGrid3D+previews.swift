//
// Created by John Griffin on 5/23/24
//

import RealityKit
import Spatial
import SwiftUI

#Preview {
    RealityUIView {
        ScaledGrid3D(
            domain: Rect3D(origin: .zero, size: .one * 1),
            gridScaleFor: .uniformFit()
        ) {
            Box3D()
                .foreground(.blue20)
                .frame(size: 0.2)
        } overlay: { _ in
//                GridDots3D(gridScale: gridScale)
        }
    }
}
