//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - RealityContent

public protocol RealityContent {
    associatedtype Body: RealityContent

    var body: Body { get }
}

// MARK: - layout and render

public extension RealityContent {
    func sizeThatFits(_ proposed: ProposedSize3D) -> Size3D {
        if let builtIn = self as? BuiltIn {
            builtIn.customSizeFor(proposed)
        } else {
            body.sizeThatFits(proposed)
        }
    }

    func render(_ context: RenderContext, size: Size3D) -> Entity {
        if let builtIn = self as? BuiltIn {
            builtIn.customRender(context, size: size)
        } else {
            body.render(context, size: size)
        }
    }
}

// MARK: - BuiltIn

public protocol BuiltIn {
    typealias Body = Never

    func customSizeFor(_ proposed: ProposedSize3D) -> Size3D
    func customRender(_ context: RenderContext, size: Size3D) -> Entity
}

public extension RealityContent where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: RealityContent {
    public typealias Body = Never
}
