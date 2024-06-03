//
// Created by John Griffin on 4/29/24
//

import RealityKit
import Spatial
import SwiftUI

/// Volume takes the space it is offered and lays out it's contents with a Stack3D(alignment: .center)
public struct Volume3D<Content: View3D>: View3D, CustomView3D {
    let content: Content
    let alignment: Alignment3D

    public init(
        @View3DBuilder content: () -> Content,
        alignment: Alignment3D = .center
    ) {
        self.content = content()
        self.alignment = alignment
    }

    public var description: String { "\(contentType)" }

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        makeEntity(
            value: alignment,
            Stack3D { content }.renderWithSize(size, proposed, env)
        )
    }
}
