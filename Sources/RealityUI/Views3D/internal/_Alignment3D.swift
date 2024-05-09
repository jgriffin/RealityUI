//
// Created by John Griffin on 5/6/24
//

import RealityKit
import Spatial

public struct _Alignment3D<Content: View3D>: View3D, CustomView3D {
    var content: Content
    var alignment: Alignment3D

    init(
        _ content: Content,
        _ alignment: Alignment3D
    ) {
        self.content = content
        self.alignment = alignment
    }

    public var description: String { "\(contentType)" }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let childSize = content.sizeThatFits(.init(size), env)

        return makeEntity(
            value: alignment,
            .translation(
                alignment.offset(parent: size, child: childSize)
            ),
            children: content.renderWithSize(size, env)
        )
    }
}
