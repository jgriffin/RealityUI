//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial

public protocol RealityLayout {
    var alignment: Alignment3D { get }

    // Calculate and return the size of the layout container.
    func sizeThatFits(
        contents: [any RealityContent],
        proposal: ProposedSize3D
    ) -> Size3D

    func placeContents(
        contents: [any RealityContent],
        in size: Size3D
    ) -> [LayoutContentPlacement]
}

public struct LayoutContentPlacement {
    let content: any RealityContent
    var size: Size3D
    var position: Point3D
}
