//
// Created by John Griffin on 4/22/24
//

import RealityKit
import Spatial

public struct _EnvironmentModifierView3D<Content: View3D, V>: View3D, CustomView3D {
    let content: Content
    let keyPath: WritableKeyPath<Environment3D, V>
    let value: V

    public init(
        _ content: Content,
        _ keyPath: WritableKeyPath<Environment3D, V>,
        _ value: V
    ) {
        self.content = content
        self.keyPath = keyPath
        self.value = value
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let updated = modify(env) {
            $0[keyPath: keyPath] = value
        }
        return content.renderWithSize(size, updated)
    }
}
