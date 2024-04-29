//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial

public protocol Layout3D {
    var alignment: Alignment3D { get }

    // Calculate and return the size of the layout container.
    func sizeThatFitsContents(
        _ contents: [any View3D],
        proposal: ProposedSize3D
    ) -> Size3D

    func placeContents(
        _ contents: [any View3D],
        in size: Size3D
    ) -> [LayoutContentPlacement]
}

public struct LayoutContentPlacement {
    let content: any View3D
    var size: Size3D
    var position: Point3D
}
