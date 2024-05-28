//
// Created by John Griffin on 5/6/24
//

import RealityKit
import Spatial
import SwiftUI

public struct _Aligned3D<Content: View3D>: View3D, CustomView3D {
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

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let offset = alignment.offsetToAlign(size, withParent: proposed)

        guard !offset.isZero else {
            return content.renderWithSize(size, proposed, env)
        }

        return makeEntity(
            value: (alignment, offset),
            children: content.renderWithSize(size, proposed, env)
                .translated(by: offset)
        )
    }
}

#if os(visionOS)

    #Preview {
        RealityUIView {
            Box3D()
                .frame(size: 0.1)
                .frame(size: 0.3, alignment: .bottomLeadingFront)
                .border()
        }
    }

#endif
