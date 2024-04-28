//
// Created by John Griffin on 4/27/24
//

import RealityKit
import Spatial

public struct RealityTuple<each Content: RealityContent>: RealityContent, CustomRealityContent, RealityTupling {
    public typealias T = (repeat each Content)
    public let value: (repeat each Content)

    public init(_ value: (repeat each Content)) {
        self.value = value
    }

    public init(_ value: repeat each Content) {
        self.value = (repeat each value)
    }

    public var contents: [any RealityContent] {
        var contents: [any RealityContent] = []
        repeat contents.append(each value)
        return contents
    }

    // MARK: - CustomRealityContent

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        RealityStack(layout: StackedLayout()) {
            self
        }.sizeThatFits(proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        RealityStack(layout: StackedLayout()) {
            self
        }.render(context, size: size)
    }
}

protocol RealityTupling {
    var contents: [any RealityContent] { get }
}

extension RealityTupling {
    var contentsCount: Int { contents.count }
}
