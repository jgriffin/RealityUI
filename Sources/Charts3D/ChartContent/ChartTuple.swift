//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct ChartTuple<each Content: ChartContent>: ChartContent, CustomChartContent, ChartTupling {
    public typealias T = (repeat each Content)
    public let value: T

    public init(_ value: (repeat each Content)) {
        self.value = value
    }

    public var contents: [any ChartContent] {
        var contents: [any ChartContent] = []
        repeat contents.append(each value)
        return contents
    }

    // MARK: - ChartContent

    // default
    public func customPlottableDomains() -> PlottableDomains {
        contents
            .map { $0.plottableDomains() }
            .reduce(into: PlottableDomains()) { result, next in result.merge(next) }
    }

    // default
    public func customRender(_ env: ChartEnvironment) -> AnyRealityContent {
        let r = rendered(env, (repeat each value))
        return r.eraseToAnyReality()
    }

    func rendered<each C: ChartContent>(
        _ env: ChartEnvironment,
        _ content: (repeat each C)
    ) -> RealityTuple< repeat (each C).RenderOutput> {
        RealityTuple(
            (repeat (each content).render(env))
        )
    }
}

// MARK: - ChartTupling

protocol ChartTupling {
    var contents: [any ChartContent] { get }
}

extension ChartTupling {
    var contentsCount: Int { contents.count }
}

// MARK: - rendering

extension ChartContent {
    typealias RenderOutput = AnyRealityContent
}

protocol Rendering {
    associatedtype Input: ChartContent
    typealias Output = AnyRealityContent
}

struct Renderer<Content: ChartContent>: Rendering {
    typealias Input = Content
}
