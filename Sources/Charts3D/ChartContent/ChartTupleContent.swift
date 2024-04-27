//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct ChartTupleContent: ChartContent, CustomChartContent {
    public let contents: [any ChartContent]

    public init(contents: [any ChartContent]) {
        self.contents = contents
    }

    public func customPlottableDomains() -> PlottableDomains {
        contents
            .map { $0.plottableDomains() }
            .reduce(into: PlottableDomains()) { result, next in result.merge(next) }
    }

    public func customRender(_ env: ChartEnvironment) -> any RealityContent {
        RealityStack(layout: CanvasLayout()) {
            contents.map {
                $0.render(env)
            }
        }
    }
}
