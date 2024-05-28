//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - View3D

public protocol View3D: CustomStringConvertible {
    associatedtype Body: View3D

    var body: Body { get }
}

public extension View3D {
    var description: String { "\(contentType)" }
}

// MARK: - layout and render

public extension View3D {
    func sizeThatFits(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        if let custom = self as? CustomView3D {
            custom.customSizeFor(proposed, env)
        } else {
            body.sizeThatFits(proposed, env)
        }
    }

    func renderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        if let custom = self as? CustomView3D {
            custom.customRenderWithSize(size, proposed, env)
        } else {
            body.renderWithSize(size, proposed, env)
        }
    }
}

// MARK: - CustomRealityContent

public protocol CustomView3D {
    func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D
    func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity
}

public extension View3D where Body == Never {
    var body: Never { fatalError("This should never be called.") }
}

extension Never: View3D {
    public typealias Body = Never
}
