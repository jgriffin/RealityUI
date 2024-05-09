//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

struct _ID3D<Content: View3D, ID: Hashable>: View3D, CustomView3D {
    let content: Content
    let id: ID

    init(_ content: Content, _ id: ID) {
        self.content = content
        self.id = id
    }

    func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        makeEntity(value: id, children: content.renderWithSize(size, env))
    }
}
