//
// Created by John Griffin on 5/23/24
//

import RealityKit
import Spatial
import SwiftUI

public struct DomainView3D<Content: View3D, Overlay: View3D>: View3D, CustomView3D {
    let domain: Rect3D
    let gridScaleFor: DomainScaleFor
    let content: Content
    let overlay: (DomainScale3D) -> Overlay

    public init(
        domain: Rect3D,
        gridScaleFor: DomainScaleFor = .uniformFit(),
        @View3DBuilder content: () -> Content,
        @View3DBuilder overlay: @escaping (DomainScale3D) -> Overlay
    ) {
        self.domain = domain
        self.gridScaleFor = gridScaleFor
        self.content = content()
        self.overlay = overlay
    }

    public init(
        domain: Rect3D,
        gridScaleFor: DomainScaleFor = .uniformFit(),
        @View3DBuilder content: () -> Content
    ) where Overlay == EmptyView3D {
        self.init(
            domain: domain,
            gridScaleFor: gridScaleFor,
            content: content,
            overlay: { _ in EmptyView3D() }
        )
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        let size = AspectRatioMath.scaledToFit(
            proposed.sizeOrDefault,
            aspectRatio: domain.size,
            maxScale: nil
        )
        return size
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let domainScale = gridScaleFor(domain: domain, size: size)

        let domainContent = content
            .frame(size: domain.size, alignment: .bottomLeadingBack)
            .offset(-.init(domain.origin))
            .scale(domainScale.scale)

        return makeEntity(
            value: domainScale,
            children: domainContent.renderWithSize(size, proposed, env),
            overlay(domainScale).renderWithSize(size, proposed, env)
        )
    }
}
