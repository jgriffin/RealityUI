//
// Created by John Griffin on 4/27/24
//

import RealityKit
import Spatial

public struct TupleView3D<each Content: View3D>: View3D, CustomView3D, View3DTupling {
    public typealias T = (repeat each Content)
    public let value: (repeat each Content)

    public init(_ value: (repeat each Content)) {
        self.value = value
    }

    public init(_ value: repeat each Content) {
        self.value = (repeat each value)
    }

    public var contents: [any View3D] {
        var contents: [any View3D] = []
        repeat contents.append(each value)
        return contents
    }

    // MARK: - CustomRealityContent

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        Stack3D(layout: StackedLayout3D()) {
            self
        }.sizeThatFits(proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        Stack3D(layout: StackedLayout3D()) {
            self
        }.render(context, size: size)
    }
}

protocol View3DTupling {
    var contents: [any View3D] { get }
}

extension View3DTupling {
    var contentsCount: Int { contents.count }
}
