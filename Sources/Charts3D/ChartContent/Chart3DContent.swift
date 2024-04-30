//
// Created by John Griffin on 4/21/24
//

import RealityUI

public protocol Chart3DContent {
    associatedtype ChartBody: Chart3DContent
    var chartBody: ChartBody { get }
}

public extension Chart3DContent {
    func plottableDomains() -> PlottableDomains {
        if let custom = self as? CustomChart3DContent {
            custom.customPlottableDomains()
        } else {
            chartBody.plottableDomains()
        }
    }

    func render(_ env: Chart3DEnvironment) -> AnyView3D {
        if let custom = self as? CustomChart3DContent {
            custom.customRender(env)
        } else {
            chartBody.render(env)
        }
    }
}

// MARK: - ChartCustomContent

public protocol CustomChart3DContent {
    func customPlottableDomains() -> PlottableDomains

    func customRender(_ env: Chart3DEnvironment) -> AnyView3D
}

public extension Chart3DContent where ChartBody == Never {
    var chartBody: Never { fatalError("This should never be called.") }
}

extension Never: Chart3DContent {
    public typealias ChartBody = Never
}

// MARK: - EmptyChartContent

public struct EmptyChart3DContent: Chart3DContent, CustomChart3DContent {
    public init() {}

    public func customPlottableDomains() -> PlottableDomains { .init() }

    public func customRender(_: Chart3DEnvironment) -> AnyView3D {
        EmptyView3D().eraseToAnyReality()
    }
}
