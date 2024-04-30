//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct TupleChart3DContent<each Content: Chart3DContent>: Chart3DContent, CustomChart3DContent, ChartTupling {
    public typealias T = (repeat each Content)
    public let value: T

    public init(_ value: (repeat each Content)) {
        self.value = value
    }

    public var contents: [any Chart3DContent] {
        var contents: [any Chart3DContent] = []
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
    public func customRender(_ env: Chart3DEnvironment) -> AnyView3D {
        let r = rendered(env, (repeat each value))
        return r.eraseToAnyReality()
    }

    func rendered<each C: Chart3DContent>(
        _ env: Chart3DEnvironment,
        _ content: (repeat each C)
    ) -> TupleView3D< repeat (each C).RenderOutput> {
        TupleView3D(
            (repeat (each content).render(env))
        )
    }
}

// MARK: - ChartTupling

protocol ChartTupling {
    var contents: [any Chart3DContent] { get }
}

extension ChartTupling {
    var contentsCount: Int { contents.count }
}

// MARK: - rendering

extension Chart3DContent {
    typealias RenderOutput = AnyView3D
}

protocol Rendering {
    associatedtype Input: Chart3DContent
    typealias Output = AnyView3D
}

struct Renderer<Content: Chart3DContent>: Rendering {
    typealias Input = Content
}
