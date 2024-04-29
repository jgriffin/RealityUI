//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial

public struct Stack3D<Content: View3D>: View3D, CustomView3D {
    let layout: any Layout3D
    let content: Content

    public init(
        layout: any Layout3D,
        @View3DBuilder content: () -> Content
    ) {
        self.layout = layout
        self.content = content()
    }

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        let contents = (content as? View3DTupling)?.contents ?? [content]
        return layout.sizeThatFitsContents(contents, proposal: proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        let contents = (content as? View3DTupling)?.contents ?? [content]
        let placements = layout.placeContents(contents, in: size)

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

public extension Stack3D {
    init(
        _ axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Size3D = .zero,
        @View3DBuilder content: () -> Content
    ) {
        self.init(
            layout: StackedLayout3D(axis: axis, alignment: alignment, spacing: spacing),
            content: content
        )
    }
}
