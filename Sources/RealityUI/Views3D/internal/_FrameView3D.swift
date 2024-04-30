//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public struct _FrameView3D<Content: View3D>: View3D, CustomView3D {
    var content: Content
    var width: Double?
    var height: Double?
    var depth: Double?
    var alignment: Alignment3D

    private func newProposedSize(_ proposed: ProposedSize3D) -> ProposedSize3D {
        .init(
            width: width ?? proposed.width,
            height: height ?? proposed.height,
            depth: depth ?? proposed.depth
        )
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        let newProposed = newProposedSize(proposed)
        let childSize = content.sizeThatFits(newProposed, env)

        return .init(
            width: width ?? childSize.width,
            height: height ?? childSize.height,
            depth: depth ?? childSize.depth
        )
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let proposed = newProposedSize(.init(size))
        let childSize = content.sizeThatFits(proposed, env)

        return makeEntity(
            .translation(
                alignment.offset(parent: proposed.sizeOrDefault, child: childSize)
            ),
            children: content.renderWithSize(size, env)
        )
    }
}
