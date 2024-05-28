//
// Created by John Griffin on 5/23/24
//

import RealityKit
import Spatial
import SwiftUI

public struct ScaledGrid3D<Content: View3D, Overlay: View3D>: View3D, CustomView3D {
    let domain: Rect3D
    let gridScaleFor: GridScaleFor
    let content: Content
    let overlay: (GridScale3D) -> Overlay

    public init(
        domain: Rect3D,
        gridScaleFor: GridScaleFor,
        @View3DBuilder content: () -> Content,
        @View3DBuilder overlay: @escaping (GridScale3D) -> Overlay
    ) {
        self.domain = domain
        self.gridScaleFor = gridScaleFor
        self.content = content()
        self.overlay = overlay
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let gridScale = gridScaleFor(domain: domain, size: size)

        return makeEntity(
            value: gridScale,
            children: content.scale(gridScale.scale).renderWithSize(size, proposed, env),
            overlay(gridScale).renderWithSize(size, proposed, env)
        )
    }
}

#if os(visionOS)

    #Preview {
        RealityUIView {
            ScaledGrid3D(
                domain: Rect3D(origin: .zero, size: .one * 1),
                gridScaleFor: .uniformFit()
            ) {
                Box3D()
                    .foreground(.blue20)
                    .frame(size: 0.2)
            } overlay: { _ in
//                GridDots3D(gridScale: gridScale)
            }
        }
    }

#endif
