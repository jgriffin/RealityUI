//
// Created by John Griffin on 4/27/24
//

import RealityKit
import Spatial

public struct AnyView3D: View3D, CustomView3D {
    public let content: any View3D

    public init(_ content: some View3D) {
        self.content = content
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        content.renderWithSize(size, env)
    }
}

public extension View3D {
    func eraseToAnyReality() -> AnyView3D {
        (self as? AnyView3D) ?? AnyView3D(self)
    }
}
