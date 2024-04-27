//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial

public struct RealityStack: RealityContent, BuiltIn {
    let layout: any RealityLayout
    let contents: [any RealityContent]

    public init(
        layout: any RealityLayout,
        @RealityContentsBuilder contents: () -> [any RealityContent]
    ) {
        self.layout = layout
        self.contents = contents()
    }

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        layout.sizeThatFits(contents: contents, proposal: proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        let placements = layout.placeContents(contents: contents, in: size)

        let children = placements.map { placement -> Entity in
            makeEntity(
                value: "stackPosition",
                .translation(.init(placement.position)),
                children: placement.content.render(context, size: placement.size)
            )
        }

        return makeEntity(
            components: [],
            children: children
        )
    }
}

public extension RealityStack {
    init(
        _ axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Size3D = .zero,
        @RealityContentsBuilder contents: () -> [any RealityContent]
    ) {
        self.init(
            layout: StackedLayout(axis: axis, alignment: alignment, spacing: spacing),
            contents: contents
        )
    }
}
