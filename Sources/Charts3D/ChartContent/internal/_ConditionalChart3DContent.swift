//
// Created by John Griffin on 4/28/24
//

import RealityUI

public struct _ConditionalChart3DContent<First: Chart3DContent, Second: Chart3DContent>: Chart3DContent {
    enum Choice { case first(First), second(Second) }

    let choice: Choice

    init(_ choice: Choice) {
        self.choice = choice
    }

    static func first(_ choice: First) -> Self { .init(.first(choice)) }
    static func second(_ choice: Second) -> Self { .init(.second(choice)) }

    public func plottableDomains() -> PlottableDomains {
        switch choice {
        case let .first(content):
            content.plottableDomains()
        case let .second(content):
            content.plottableDomains()
        }
    }

    @View3DBuilder
    public func renderView(_ proxy: Chart3DProxy, _ env: Chart3DEnvironment) -> some View3D {
        switch choice {
        case let .first(content):
            content.renderView(proxy, env)
        case let .second(content):
            content.renderView(proxy, env)
        }
    }
}
