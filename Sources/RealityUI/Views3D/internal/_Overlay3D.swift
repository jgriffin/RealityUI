//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public struct _Overlay3D<Content: View3D, OverlayContent: View3D>: View3D, CustomView3D {
    var content: Content
    var overlay: OverlayContent
    var alignment: Alignment3D

    public init(_ content: Content, overlay: OverlayContent, alignment: Alignment3D) {
        self.content = content
        self.overlay = overlay
        self.alignment = alignment
    }

    public var description: String {
        "\(contentType) alignment: ???"
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        content.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        makeEntity(
            children: content.renderWithSize(size, env),
            _Alignment3D(overlay, alignment).renderWithSize(size, env)
        )
    }
}
