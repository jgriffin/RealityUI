//
// Created by John Griffin on 4/19/24
//

import RealityKit
import Spatial
import SwiftUI

/// A Stack3D uses a Layout3D to determing the size and position of the (flattened) contents
///
/// AxisStackedLayout3D is analagous to SwiftUI HStack and VStack
/// AlignmentLayout3D is analagous to a SwiftUI ZStack
public struct Stack3D<Layout: Layout3D, Content: View3D>: View3D, CustomView3D {
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

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let contents = groupFlattened(content)
        let placements = layout.placeContents(contents, in: size, env)

        let children = placements.map { placement -> Entity in
            placement.content
                .renderWithSize(placement.size, proposed, env)
                .translated(by: placement.position)
        }

        return makeEntity(
            value: layout,
            components: [],
            children: children
        )
    }
}
