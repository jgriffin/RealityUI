//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct _Environment3DModifier<Content: Chart3DContent, V>: Chart3DContent {
    let content: Content
    let keyPath: WritableKeyPath<Chart3DEnvironment, V>
    let value: V

    public init(
        _ content: Content,
        _ keyPath: WritableKeyPath<Chart3DEnvironment, V>,
        _ value: V
    ) {
        self.content = content
        self.keyPath = keyPath
        self.value = value
    }

    public func plottableDomains() -> PlottableDomains {
        content.plottableDomains()
    }

    public func renderView(_ proxy: Chart3DProxy, _ env: Chart3DEnvironment) -> some View3D {
        let updatedEnv = modify(env) {
            $0[keyPath: keyPath] = value
        }
        return content.renderView(proxy, updatedEnv)
    }
}
