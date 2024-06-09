//
// Created by John Griffin on 6/9/24
//

import RealityKit
import Spatial

public struct _FixedSize3D<Content: View3D>: View3D, CustomView3D {
    let content: Content
    let horizontal: Bool
    let vertical: Bool

    public func customSizeFor(_ p: ProposedSize3D, _ env: Environment3D) -> Size3D {
        var proposed = p

        if horizontal { proposed.width = nil }
        if vertical { proposed.height = nil }

        return content.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        content.renderWithSize(size, proposed, env)
    }
}
