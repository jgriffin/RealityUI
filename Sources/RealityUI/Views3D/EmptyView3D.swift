//
// Created by John Griffin on 4/27/24
//

import RealityKit
import Spatial

// MARK: - EmptyView3D

public struct EmptyView3D: View3D, CustomView3D {
    public init() {}

    public func customSizeFor(_: ProposedSize3D, _: Environment3D) -> Size3D { .zero }

    public func customRenderWithSize(_: Size3D, _: Size3D, _: Environment3D) -> Entity {
        makeEntity(value: ())
    }
}
