//
// Created by John Griffin on 4/21/24
//

import RealityUI

public protocol ChartContent {
    associatedtype ChartBody: ChartContent
    var chartBody: ChartBody { get }
}

public extension ChartContent {
    func plottableDomains() -> PlottableDomains {
        if let custom = self as? CustomChartContent {
            custom.customPlottableDomains()
        } else {
            chartBody.plottableDomains()
        }
    }

    func render(_ env: ChartEnvironment) -> AnyView3D {
        if let custom = self as? CustomChartContent {
            custom.customRender(env)
        } else {
            chartBody.render(env)
        }
    }
}

// MARK: - ChartCustomContent

public protocol CustomChartContent {
    func customPlottableDomains() -> PlottableDomains

    func customRender(_ env: ChartEnvironment) -> AnyView3D
}

public extension ChartContent where ChartBody == Never {
    var chartBody: Never { fatalError("This should never be called.") }
}

extension Never: ChartContent {
    public typealias ChartBody = Never
}

// MARK: - EmptyChartContent

public struct EmptyChartContent: ChartContent, CustomChartContent {
    public init() {}

    public func customPlottableDomains() -> PlottableDomains { .init() }

    public func customRender(_: ChartEnvironment) -> AnyView3D {
        EmptyView3D().eraseToAnyReality()
    }
}
