//
// Created by John Griffin on 4/27/24
//

import RealityKit
import Spatial

public struct TupleView3D<each Content: View3D>: View3D, CustomView3D {
    public typealias T = (repeat each Content)
    public let value: (repeat each Content)

    public init(_ value: (repeat each Content)) {
        self.value = value
    }

    public init(_ value: repeat each Content) {
        self.value = (repeat each value)
    }

    // MARK: - _GroupingView3D

    var contents: [any View3D] {
        var contents: [any View3D] = []
        repeat contents.append(each value)
        return contents
    }

    // MARK: - CustomRealityContent

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        LayoutView3D(.stacked(axis: .right)) {
            self
        }.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        LayoutView3D(.stacked(axis: .right)) {
            self
        }.renderWithSize(size, env)
    }
}

extension TupleView3D: _GroupingView3D {}
