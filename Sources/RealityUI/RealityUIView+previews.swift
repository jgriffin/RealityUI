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

#Preview {
    RealityUIView {
        Box3D()
            .foreground(.color(.css(basic: .lime)))
            .frame(size: 0.5)
            .scaledToFit()
            .padding(0.01)
    }
}
