//
// Created by John Griffin on 5/23/24
//

import RealityKit
import Spatial
import SwiftUI

public struct ScaledGrid3D<Content: View3D, Overlay: View3D>: View3D {
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

    public var body: some View3D {
        Geometry3DReader { size in
            let gridScale = gridScaleFor(domain: domain, size: size)

            Stack3D {
                content.scale(gridScale.scale)
                overlay(gridScale) // .frame(size: gridScale.bounds.size)
            }
        }
    }
}

#if os(visionOS)

    #Preview {
        RealityUIView {
            ScaledGrid3D(
                domain: Rect3D(center: .zero, size: .one * 2),
                gridScaleFor: .uniformFit()
            ) {
                Box3D()
                    .foreground(.blue20)
                    .aspectRatio(.one)
            } overlay: { gridScale in
                GridDots3D(gridScale: gridScale)
            }
        }
    }

#endif
