//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public struct _OverlayView3D<Content: View3D, OverlayContent: View3D>: View3D, CustomView3D {
    var content: Content
    var overlay: OverlayContent

    public init(_ content: Content, overlay: OverlayContent) {
        self.content = content
        self.overlay = overlay
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let contentSize = content.sizeThatFits(.init(size), env)
        let overlaySize = overlay.sizeThatFits(.init(contentSize), env)

        return makeEntity(children:
            content.renderWithSize(contentSize, env),
            overlay.renderWithSize(overlaySize, env))
    }
}
