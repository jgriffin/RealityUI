//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

public struct _Pose3D<Content: View3D>: View3D, CustomView3D {
    var content: Content
    var pose: Pose3D

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        makeEntity(
            value: pose,
            component: .transform(.init(pose: pose)),
            content.renderWithSize(size, proposed, env)
        )
    }
}
