//
// Created by John Griffin on 5/6/24
//

import RealityKit
import Spatial
import SwiftUI

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
            children: content
                .offset(alignment.offset(parent: size, child: childSize))
                .renderWithSize(size, env)
        )
    }
}

#if os(visionOS)

    #Preview {
        RealityUIView {
            Box3D()
                .frame(size: 0.1)
        }
    }

#endif
