//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct _ChartEnvironmentModifier<Content: Chart3DContent, V>: Chart3DContent, CustomChart3DContent {
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

    public func customPlottableDomains() -> PlottableDomains {
        content.plottableDomains()
    }

    public func customRender(_ env: Chart3DEnvironment) -> AnyView3D {
        let updatedEnv = modify(env) {
            $0[keyPath: keyPath] = value
        }
        return content.render(updatedEnv)
    }
}
