//
// Created by John Griffin on 4/22/24
//

import RealityKit
import Spatial

public struct RealityEnvironmentModifier<Content: RealityContent, V>: RealityContent, CustomRealityContent {
    let content: Content
    let keyPath: WritableKeyPath<RealityEnvironment, V>
    let value: V

    public init(
        _ content: Content,
        _ keyPath: WritableKeyPath<RealityEnvironment, V>,
        _ value: V
    ) {
        self.content = content
        self.keyPath = keyPath
        self.value = value
    }

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        content.sizeThatFits(proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        let updated = modify(context) {
            $0.environment[keyPath: keyPath] = value
        }
        return content.render(updated, size: size)
    }
}
