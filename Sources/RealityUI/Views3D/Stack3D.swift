//
// Created by John Griffin on 4/29/24
//

import RealityKit
import Spatial

public struct Stack3D<Content: View3D>: View3D {
    let layoutView: LayoutView3D<StackedLayout3D, Content>

    public init(
        axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Size3D = .zero,
        @View3DBuilder content: () -> Content
    ) {
        layoutView = LayoutView3D(
            .stacked(axis: axis, alignment: alignment, spacing: spacing),
            content: content
        )
    }

    public init(
        axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Double,
        @View3DBuilder content: () -> Content
    ) {
        layoutView = LayoutView3D(
            .stacked(axis: axis, alignment: alignment, spacing: .one * spacing),
            content: content
        )
    }

    public var body: some View3D {
        layoutView
    }
}
