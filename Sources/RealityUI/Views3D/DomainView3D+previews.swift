//
// Created by John Griffin on 5/23/24
//

import RealityKit
import Spatial
import SwiftUI

#Preview {
    RealityUIView {
        DomainView3D(
            domain: Rect3D(origin: .zero, size: .one * 1)
        ) {
            Box3D()
                .foreground(.blue20)
                .frame(size: 0.2)
        }
    }
}

#Preview {
    RealityUIView {
        Stack3D(axis: .right, alignment: .bottom) {
            DomainView3D(
                domain: Rect3D(origin: .zero, size: .init(width: 10, height: 100, depth: 10))
            ) {
                Box3D()
                    .frame(size: .init(width: 10, height: 50, depth: 10))
            }
            DomainView3D(
                domain: Rect3D(origin: .zero, size: .init(width: 10, height: 100, depth: 10))
            ) {
                Box3D()
//                    .frame(size: .init(width: 10, height: 50, depth: 10))
            }
        }
        .foreground(.blue80)
        .border()
    }
}
