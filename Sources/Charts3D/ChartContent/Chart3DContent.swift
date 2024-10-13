//
// Created by John Griffin on 4/21/24
//

import RealityUI

@MainActor public protocol Chart3DContent: CustomStringConvertible {
    associatedtype View3DBody: View3D

    func plottableDomains() -> PlottableDomains
    func renderView(_ proxy: Chart3DProxy, _ env: Chart3DEnvironment) -> View3DBody
}

public extension Chart3DContent {
    nonisolated var description: String { "\(Self.self)" }
}

// MARK: - EmptyChartContent

public struct EmptyChart3DContent: Chart3DContent {
    public init() {}

    public func plottableDomains() -> PlottableDomains { .init() }

    public func renderView(_: Chart3DProxy, _: Chart3DEnvironment) -> some View3D {
        EmptyView3D()
    }
}
