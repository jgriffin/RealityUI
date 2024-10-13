//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial
import SwiftUI

#Preview {
    RealityView3D {
        Box3D()
            .overlay(alignment: .bottomLeadingFront) {
                Box3D()
                    .scale(by: 0.5)
            }
            .foreground(.cyan20)
    }
}
