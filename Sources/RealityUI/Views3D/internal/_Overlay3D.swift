//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial
import SwiftUI

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

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        makeEntity(
            value: alignment,
            children: content.renderWithSize(size, proposed, env),
            overlay.aligned(alignment).renderWithSize(size, proposed, env)
        )
    }
}

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            _Overlay3D(
                Box3D().foreground(.cyan20),
                overlay: Sphere3D().foreground(.blue100),
                alignment: .leading
            )
        }
    }

#endif
