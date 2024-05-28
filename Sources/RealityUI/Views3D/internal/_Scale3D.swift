//
// Created by John Griffin on 4/20/24
//

import RealityKit
import Spatial
import SwiftUI

public struct _Scale3D<Content: View3D>: View3D, CustomView3D {
    let content: Content
    let scale: Size3D

    public init(
        content: Content,
        scale: Size3D
    ) {
        self.content = content
        self.scale = scale
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        let childSize = content.sizeThatFits(proposed, env)
        return childSize.scaled(by: scale)
    }

    public func customRenderWithSize(_: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        makeEntity(
            value: scale,
            component: .transform(AffineTransform3D(scale: scale)),
            content.renderWithSize(proposed, proposed, env)
        )
    }
}

#if os(visionOS)

    #Preview {
        RealityUIView {
            _Scale3D(
                content: Box3D().frame(size: 0.2).offset(.init(.one * 0.2)),
                scale: .one * 0.5
            )
        }
    }

#endif
