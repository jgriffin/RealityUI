//
// Created by John Griffin on 4/27/24
//

import RealityKit
import Spatial

public struct AnyRealityContent: RealityContent, BuiltIn {
    let content: any RealityContent

    public init(_ content: some RealityContent) {
        self.content = content
    }

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        content.sizeThatFits(proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        content.render(context, size: size)
    }
}

public extension RealityContent {
    func eraseToAnyReality() -> AnyRealityContent {
        (self as? AnyRealityContent) ?? AnyRealityContent(self)
    }
}
