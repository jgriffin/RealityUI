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

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        content.sizeThatFits(proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        content.render(context, size: size)
    }
}

public extension View3D {
    func eraseToAnyReality() -> AnyView3D {
        (self as? AnyView3D) ?? AnyView3D(self)
    }
}
