//
// Created by John Griffin on 5/27/24
//

import RealityKit
import Spatial
import SwiftUI

#Preview {
    RealityUIView {
        Stack3D(axis: .right, alignment: .bottomLeading, spacing: 0.2) {
            Box3D()
                .frame(size: 0.3).border()
            Box3D()
                .frame(minWidth: 0.4, alignment: .bottom)
                .frame(size: 0.3).border()
            Box3D()
                .frame(minHeight: 0.5, alignment: .bottom)
                .frame(size: 0.3).border()

            Box3D()
                .frame(maxHeight: 0.2, alignment: .bottom)
                .frame(size: 0.3).border()

            Box3D()
                .frame(maxWidth: 0.2, alignment: .bottom)
                .frame(size: 0.3).border()
            Box3D()
                .frame(maxHeight: 0.2, alignment: .bottom)
                .frame(size: 0.3).border()
        }
        .frame(minWidth: 2)
        .border()
    }
}
