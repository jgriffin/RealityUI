//
// Created by John Griffin on 4/20/24
//

import RealityKit
import Spatial

public struct _Scale3D<Content: View3D>: View3D, CustomView3D {
    var content: Content
    var scale: Size3D

    public init(
        content: Content,
        scale: Size3D
    ) {
        self.content = content
        self.scale = scale
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        let childSize = content.sizeThatFits(proposed, env)
        return childSize.scaled(by: scale)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let childSize = content.sizeThatFits(.init(size), env)

        return makeEntity(
            .transform(AffineTransform3D(scale: scale)),
            children: content.renderWithSize(childSize, env)
        )
    }
}
