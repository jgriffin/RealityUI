//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

public enum ConditionalRealityContent<First: RealityContent, Second: RealityContent>: RealityContent, BuiltIn {
    case first(First),
         second(Second)

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        switch self {
        case let .first(content):
            content.sizeThatFits(proposed)
        case let .second(content):
            content.sizeThatFits(proposed)
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
