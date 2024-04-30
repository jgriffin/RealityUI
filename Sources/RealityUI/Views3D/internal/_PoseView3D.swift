//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

public struct _PoseView3D<Content: View3D>: View3D, CustomView3D {
    var content: Content
    var pose: Pose3D

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        makeEntity(
            value: pose,
            .transform(.init(pose: pose)),
            children: content.render(context, size: size)
        )
    }
}
