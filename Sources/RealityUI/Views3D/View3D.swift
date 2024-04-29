//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - View3D

public protocol View3D {
    associatedtype Body: View3D

    var body: Body { get }
}

// MARK: - layout and render

public extension View3D {
    func sizeThatFits(_ proposed: ProposedSize3D) -> Size3D {
        if let custom = self as? CustomView3D {
            custom.customSizeFor(proposed)
        } else {
            body.sizeThatFits(proposed)
        }
    }

    func render(_ context: RenderContext, size: Size3D) -> Entity {
        if let custom = self as? CustomView3D {
            custom.customRender(context, size: size)
        } else {
            body.render(context, size: size)
        }
    }
}

// MARK: - CustomRealityContent

public protocol CustomView3D {
    func customSizeFor(_ proposed: ProposedSize3D) -> Size3D
    func customRender(_ context: RenderContext, size: Size3D) -> Entity
}

public extension View3D where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: View3D {
    public typealias Body = Never
}
