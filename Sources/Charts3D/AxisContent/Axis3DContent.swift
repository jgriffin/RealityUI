//
// Created by John Griffin on 4/30/24
//

import RealityUI

/// essentially Axis3DMarks
public protocol Axis3DContent {
    associatedtype View3DBody: View3D

    @View3DBuilder
    func renderView(_ proxy: DimensionProxy, _ env: Chart3DEnvironment) -> View3DBody
}

public extension Axis3DContent {
    func eraseToAnyAxis3DContent() -> AnyAxis3DContent { .init(self) }
}

public struct AnyAxis3DContent: Axis3DContent {
    let content: any Axis3DContent

    public init(content: any Axis3DContent) {
        self.content = content
    }

    public init(_ content: some Axis3DContent) {
        self.content = content
    }

    public func renderView(_ proxy: DimensionProxy, _ env: Chart3DEnvironment) -> some View3D {
        content.renderView(proxy, env).eraseToAnyView3D()
    }
}
