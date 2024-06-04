//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial
import SwiftUI

public extension Stack3D {
    init(
        @View3DBuilder content: () -> Content
    ) where Layout == AlignmentLayout3D {
        self.init(.alignment(alignment: .center), content: content)
    }

    init(
        alignment: Alignment3D,
        @View3DBuilder content: () -> Content
    ) where Layout == AlignmentLayout3D {
        self.init(.alignment(alignment: alignment), content: content)
    }

    init(
        axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Size3D = .zero,
        @View3DBuilder content: () -> Content
    ) where Layout == AxisStackedLayout3D {
        self.init(
            .axisStacked(axis: axis, alignment: alignment, spacing: spacing),
            content: content
        )
    }

    init(
        axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Double,
        @View3DBuilder content: () -> Content
    ) where Layout == AxisStackedLayout3D {
        self.init(
            .axisStacked(axis: axis, alignment: alignment, spacing: .one * spacing),
            content: content
        )
    }
}
