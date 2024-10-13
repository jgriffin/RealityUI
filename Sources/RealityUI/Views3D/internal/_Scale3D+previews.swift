//
// Created by John Griffin on 6/3/24
//

import Spatial
import SwiftUI

#Preview {
    RealityView3D {
        _Scale3D(
            content: Box3D().frame(size: 0.2).offset(.init(.one * 0.2)),
            scale: .one * 0.5
        )
    }
}
