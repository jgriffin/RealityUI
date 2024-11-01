//
// Created by John Griffin on 5/25/24
//

import RealityKit
import Spatial
import SwiftUI

public struct Geometry3DReader<Content: View3D>: View3D, CustomView3D {
    let content: (Size3D) -> Content

    public init(@View3DBuilder content: @escaping (Size3D) -> Content) {
        self.content = content
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let content = content(size)

        return makeEntity(
            value: "geometryReader",
            children: content.renderWithSize(size, proposed, env)
        )
    }
}

#Preview {
    RealityView3D {
        Geometry3DReader { _ in
            Box3D()
                .frame(size: 0.1)
        }
    }
}
