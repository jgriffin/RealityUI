//
// Created by John Griffin on 4/27/24
//

import RealityKit
import Spatial

// MARK: - EmptyContent

public struct EmptyContent: RealityContent, CustomRealityContent {
    public init() {}

    public func customSizeFor(_: ProposedSize3D) -> Size3D { .zero }

    public func customRender(_: RenderContext, size _: Size3D) -> Entity {
        makeEntity()
    }
}
