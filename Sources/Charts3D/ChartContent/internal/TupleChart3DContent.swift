//
// Created by John Griffin on 4/22/24
//

import RealityUI

public struct TupleChart3DContent<each Content: Chart3DContent>: Chart3DContent {
    public let value: (repeat each Content)

    public init(_ value: (repeat each Content)) {
        self.value = value
    }

//    public init(_ value: repeat each Content) {
//        self.value = (repeat each value)
//    }

    public var contents: [any Chart3DContent] {
        var contents: [any Chart3DContent] = []
        repeat contents.append(each value)
        return contents
    }

    // MARK: - ChartContent

    public func plottableDomains() -> PlottableDomains {
        contents
            .map { $0.plottableDomains() }
            .reduce(into: PlottableDomains()) { result, next in result.merge(next) }
    }

    public func renderView(_ proxy: Chart3DProxy, _ env: Chart3DEnvironment) -> TupleView3D< repeat (each Content).View3DBody> {
        TupleView3D(repeat (each value).renderView(proxy, env))
    }
}

extension TupleChart3DContent: ChartTupling {}

// MARK: - ChartTupling

@MainActor protocol ChartTupling {
    var contents: [any Chart3DContent] { get }
}

extension ChartTupling {
    var contentsCount: Int { contents.count }
}
