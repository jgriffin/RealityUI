//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

public enum _Conditional3D<First: View3D, Second: View3D>: View3D, CustomView3D {
    case first(First),
         second(Second)

    public nonisolated var description: String {
        switch self {
        case .first: "\(contentType) .first"
        case .second: "\(contentType) .second"
        }
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        switch self {
        case let .first(content):
            content.sizeThatFits(proposed, env)
        case let .second(content):
            content.sizeThatFits(proposed, env)
        }
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        switch self {
        case let .first(content):
            content.renderWithSize(size, proposed, env)
        case let .second(content):
            content.renderWithSize(size, proposed, env)
        }
    }
}
