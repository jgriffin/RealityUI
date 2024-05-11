//
// Created by John Griffin on 4/29/24
//

import RealityKit
import Spatial
import SwiftUI

/// Doesn't do any layout, just returns the proposed size and draws things where they are
/// The canvas size itself does get aligned so it plays well with other stuff.
public struct Canvas3D<Content: View3D>: View3D, CustomView3D {
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

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let contents = groupFlattened(content)

        return makeEntity(
            children: contents.map {
                $0.renderWithSize(size, env)
            }
        )
    }
}

#if os(visionOS)

    #Preview(windowStyle: .volumetric) {
        RealityUIView {
            Canvas3D {
                Box3D()
                    .foreground(.cyan20)
            }
        }
    }

#endif
