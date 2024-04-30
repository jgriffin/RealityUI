//
// Created by John Griffin on 4/28/24
//

import RealityUI

public enum _ConditionalChart3DContent<First: Chart3DContent, Second: Chart3DContent>: Chart3DContent, CustomChart3DContent {
    case first(First),
         second(Second)

    public func customPlottableDomains() -> PlottableDomains {
        switch self {
        case let .first(content):
            content.plottableDomains()
        case let .second(content):
            content.plottableDomains()
        }
    }

    public func customRender(_ env: Chart3DEnvironment) -> AnyView3D {
        switch self {
        case let .first(content):
            content.render(env)
        case let .second(content):
            content.render(env)
        }
    }
}
