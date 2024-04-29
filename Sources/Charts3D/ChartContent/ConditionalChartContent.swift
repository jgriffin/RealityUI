//
// Created by John Griffin on 4/28/24
//

import RealityUI

public enum ConditionalChartContent<First: ChartContent, Second: ChartContent>: ChartContent, CustomChartContent {
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

    public func customRender(_ env: ChartEnvironment) -> AnyView3D {
        switch self {
        case let .first(content):
            content.render(env)
        case let .second(content):
            content.render(env)
        }
    }
}
