//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial

public struct LayoutView3D<Layout: Layout3D, Content: View3D>: View3D, CustomView3D {
    let layout: Layout
    let content: Content

    public init(
        _ layout: Layout,
        @View3DBuilder content: () -> Content
    ) {
        self.layout = layout
        self.content = content()
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        let contents = groupFlattened(content)
        return layout.sizeThatFitsContents(contents, proposal: proposed, env)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        let contents = groupFlattened(content)
        let placements = layout.placeContents(contents, in: size, context.environment)

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
