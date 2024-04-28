//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct ChartTuple<each Content: ChartContent>: ChartContent, ChartTupling {
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
    public func customRender(_: ChartEnvironment) -> AnyRealityContent {
        fatalError()
//        let r = renderers(env, value)
//        let t = tupled(r)
//
//        return t.eraseToAnyReality()
    }

    func renderers<each C: ChartContent>(
        _ env: ChartEnvironment,
        _ content: (repeat each C)
    ) -> (repeat Renderer<each C>) {
        (repeat Renderer(env, each content))
    }

    func tupled<each R: Rendering>(_ renderer: (repeat each R)) -> AnyRealityContent {
        RealityTuple(repeat (each renderer).realityContent())
            .eraseToAnyReality()
    }
}

protocol ChartTupling {
    var contents: [any ChartContent] { get }
}

extension ChartTupling {
    var contentsCount: Int { contents.count }
}

public extension ChartContent {
    typealias RenderType = AnyRealityContent
}

extension RealityContent {
    typealias AnyType = AnyRealityContent
}

protocol Rendering {
    associatedtype Content: ChartContent
    associatedtype Output: RealityContent

    func realityContent() -> Output
}

struct Renderer<Content: ChartContent>: Rendering {
    let env: ChartEnvironment
    let content: Content

    init(_ env: ChartEnvironment, _ content: Content) {
        self.env = env
        self.content = content
    }

    func realityContent() -> AnyRealityContent {
        content.render(env)
    }
}
