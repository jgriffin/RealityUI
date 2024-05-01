//
// Created by John Griffin on 4/21/24
//

import RealityUI

public protocol Chart3DContent {
    associatedtype View3DBody: View3D

    func plottableDomains() -> PlottableDomains
    func renderView(_ proxy: Chart3DProxy, _ env: Chart3DEnvironment) -> View3DBody
}

// MARK: - EmptyChartContent

public struct EmptyChart3DContent: Chart3DContent {
    public init() {}

    public func plottableDomains() -> PlottableDomains { .init() }

    public func renderView(_: Chart3DProxy, _: Chart3DEnvironment) -> some View3D {
        EmptyView3D()
    }
}
