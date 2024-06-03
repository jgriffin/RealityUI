//
// Created by John Griffin on 4/28/24
//

import Spatial
import SwiftUI

#Preview {
    let points = [
        Vector3D.bottomLeading, .bottomTrailing, .topTrailing, .topLeading, .bottomLeading,
    ].map { Point3D($0 * 0.2) }

    return RealityUIView {
        Line3D(points)
            .frame(size: 0.5)
            .padding(0.01)
    }
}
