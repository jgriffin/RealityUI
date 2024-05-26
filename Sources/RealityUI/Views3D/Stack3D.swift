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

    public var description: String {
        "\(contentType) \(layout)"
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        let contents = groupFlattened(content)
        return layout.sizeThatFitsContents(contents, proposal: proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let contents = groupFlattened(content)
        let childrenSize = customSizeFor(.init(size), env)
        let placements = layout.placeContents(contents, in: size, env)

        let children = placements.map { placement -> Entity in
            makeEntity(
                value: "stackPosition",
                .translation(.init(placement.position)),
                children: placement.content.renderWithSize(placement.size, env)
            )
        }

        return makeEntity(
            value: layout,
            .translation(-Alignment3D.center.offset(parent: size, child: childrenSize)),
            children: children
        )
    }
}

public extension Stack3D {
    init(
        @View3DBuilder content: () -> Content
    ) where Layout == AlignmentLayout3D {
        self.init(.alignment(alignment: .center), content: content)
    }

    init(
        alignment: Alignment3D,
        @View3DBuilder content: () -> Content
    ) where Layout == AlignmentLayout3D {
        self.init(.alignment(alignment: alignment), content: content)
    }

    init(
        axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Size3D = .zero,
        @View3DBuilder content: () -> Content
    ) where Layout == AxisStackedLayout3D {
        self.init(
            .axisStacked(axis: axis, alignment: alignment, spacing: spacing),
            content: content
        )
    }

    init(
        axis: Vector3D,
        alignment: Alignment3D = .center,
        spacing: Double,
        @View3DBuilder content: () -> Content
    ) where Layout == AxisStackedLayout3D {
        self.init(
            .axisStacked(axis: axis, alignment: alignment, spacing: .one * spacing),
            content: content
        )
    }
}

#if os(visionOS)

    #Preview {
        RealityUIView {
            Stack3D(alignment: .center) {
                Box3D()
                    .frame(size: .one * 0.2)
                Sphere3D()
                    .frame(size: .one * 0.2)
                Box3D()
            }
            .foreground(.cyan20)
        }
    }

#endif
