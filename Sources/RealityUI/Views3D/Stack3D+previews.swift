//
// Created by John Griffin on 5/27/24
//

import RealityKit
import Spatial
import SwiftUI

#Preview(".center") {
    RealityView3D {
        Stack3D {
            Box3D()
                .frame(size: 0.1)
                .scale(by: 0.5)
                .offset(.init(x: -0.2, y: 0, z: 0))

            Box3D()
                .frame(size: 0.1)

            Sphere3D()
                .frame(size: 0.1)
                .offset(.init(x: 0.2, y: 0, z: 0))
        }
        .border()
        .frame(size: 0.2)
        .foreground(.cyan20)
    }
}

#Preview(".right bottom") {
    RealityView3D {
        Stack3D(axis: .right, alignment: .bottom) {
            Box3D()
                .frame(size: .init(width: 0.2, height: 0.5, depth: 0.2))

            Box3D()
                .frame(size: .init(width: 0.2, height: 0.8, depth: 0.2))
        }
        .border()
        .frame(size: 0.2)
        .foreground(.cyan20)
    }
}
