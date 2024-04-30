//
// Created by John Griffin on 4/21/24
//

import RealityKit
import Spatial

public struct _OffsetView3D<Content: View3D>: View3D, CustomView3D {
    var content: Content
    var offset: Vector3D

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        makeEntity(
            value: offset,
            .translation(offset),
            children: content.render(context, size: size)
        )
    }
}
