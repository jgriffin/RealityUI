//
// Created by John Griffin on 6/3/24
//

import Spatial
import SwiftUI

#Preview {
    RealityView3D {
        Box3D()
            .frame(size: 0.1)
            .frame(size: 0.3, alignment: .bottomLeadingFront)
            .border()
    }
}
