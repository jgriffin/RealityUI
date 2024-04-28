//
// Created by John Griffin on 4/22/24
//

import RealityUI
import SwiftUI

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            Chart3D {
                Point3DMark(("x", "y", "z"), (0, 0, 0))
                Point3DMark(("x", "y", "z"), (2, 2, 2))
            }
        }
    }

#endif
