//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

public enum _ConditionalView3D<First: View3D, Second: View3D>: View3D, CustomView3D {
    case first(First),
         second(Second)

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        switch self {
        case let .first(content):
            content.sizeThatFits(proposed, env)
        case let .second(content):
            content.sizeThatFits(proposed, env)
        }
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        switch self {
        case let .first(content):
            content.render(context, size: size)
        case let .second(content):
            content.render(context, size: size)
        }
    }
}
