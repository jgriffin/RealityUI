//
// Created by John Griffin on 5/27/24
//

import RealityKit
import Spatial
import SwiftUI

#Preview {
    RealityUIView {
        Box3D()
            .frame(width: 0.3, height: 0.2, depth: 0.1, alignment: .center)
            .frame(size: 0.4, alignment: .bottomLeadingFront)
            .border()
    }
}
