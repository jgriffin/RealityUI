//
// Created by John Griffin on 4/20/24
//

import RealityKit
import Spatial

public struct _Padding3D<Content: View3D>: View3D, CustomView3D {
    var content: Content
    var edgeInsets: EdgeInsets3D

    init(content: Content, edgeInsets: EdgeInsets3D) {
        self.content = content
        self.edgeInsets = edgeInsets
    }

    private func newProposedSize(_ proposed: ProposedSize3D) -> ProposedSize3D {
        ProposedSize3D(
            width: proposed.width.map { $0 - edgeInsets.size.width },
            height: proposed.height.map { $0 - edgeInsets.size.height },
            depth: proposed.depth.map { $0 - edgeInsets.size.depth }
        )
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        let newProposed = newProposedSize(proposed)
        let childSize = content.sizeThatFits(newProposed, env)
        return childSize + edgeInsets.size
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let translation = Vector3D(
            x: (edgeInsets.trailing - edgeInsets.leading) / 2,
            y: (edgeInsets.top - edgeInsets.bottom) / 2,
            z: (edgeInsets.front - edgeInsets.back) / 2
        )
        return makeEntity(
            value: edgeInsets,
            children: content
                .renderWithSize(size - edgeInsets.size, proposed - edgeInsets.size, env)
                .translated(by: translation)
        )
    }
}
