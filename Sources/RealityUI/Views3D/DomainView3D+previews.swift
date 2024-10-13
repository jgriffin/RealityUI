//
// Created by John Griffin on 5/23/24
//

import RealityKit
import Spatial
import SwiftUI

#Preview {
    RealityView3D {
        DomainView3D(
            domain: Rect3D(origin: .zero, size: .one * 5),
            domainPadding: .init(0.5)
        ) {
            Box3D().frame(size: 1)
            Box3D().frame(size: 1)
                .offset(.init(x: 1, y: 1, z: 1))
            Box3D().frame(size: 1)
                .offset(.init(x: 2, y: 2, z: 2))
            Box3D().frame(size: 1)
                .offset(.init(x: 3, y: 3, z: 3))
            Box3D().frame(size: 1)
                .offset(.init(x: 4, y: 4, z: 4))
            Box3D().frame(size: 1)
                .offset(.init(x: 5, y: 5, z: 5))
        }
        .foreground(.blue80)
        .border()
    }
}

#Preview {
    RealityView3D {
        Stack3D(axis: .right, alignment: .bottom, spacing: 0.01) {
            DomainView3D(
                domain: Rect3D(origin: .zero, size: .init(width: 10, height: 100, depth: 10))
            ) {
                Box3D()
                    .frame(size: .init(width: 10, height: 50, depth: 10))
                    .offset(anchor: .bottomLeadingBack)
            }
            DomainView3D(
                domain: Rect3D(origin: .zero, size: .init(width: 10, height: 100, depth: 10))
            ) {
                Box3D()
                    .offset(anchor: .bottomLeadingBack)
            }
        }
        .foreground(.blue80)
        .border()
    }
}
