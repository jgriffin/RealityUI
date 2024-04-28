//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct ChartEnvironmentModifier<Content: ChartContent, V>: ChartContent, CustomChartContent {
    let content: Content
    let keyPath: WritableKeyPath<ChartEnvironment, V>
    let value: V

    public init(
        _ content: Content,
        _ keyPath: WritableKeyPath<ChartEnvironment, V>,
        _ value: V
    ) {
        self.content = content
        self.keyPath = keyPath
        self.value = value
    }

    public func customPlottableDomains() -> PlottableDomains {
        content.plottableDomains()
    }

    public func customRender(_ env: ChartEnvironment) -> AnyRealityContent {
        let updatedEnv = modify(env) {
            $0[keyPath: keyPath] = value
        }
        return content.render(updatedEnv)
    }
}
