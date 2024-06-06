//
// Created by John Griffin on 5/23/24
//

import RealityKit
import Spatial
import SwiftUI

public struct DomainView3D<Content: View3D, Overlay: View3D>: View3D, CustomView3D {
    let domain: Rect3D
    let domainPadding: EdgeInsets3D
    let gridScaleFor: DomainScaleFor
    let content: Content
    let overlay: (DomainScale3D) -> Overlay

    public init(
        domain: Rect3D,
        domainPadding: EdgeInsets3D = .init(0.5),
        gridScaleFor: DomainScaleFor = .uniformFit,
        @View3DBuilder content: () -> Content,
        @View3DBuilder overlay: @escaping (DomainScale3D) -> Overlay
    ) {
        self.domain = domain
        self.domainPadding = domainPadding
        self.gridScaleFor = gridScaleFor
        self.content = content()
        self.overlay = overlay
    }

    public init(
        domain: Rect3D,
        domainPadding: EdgeInsets3D = .zero,
        gridScaleFor: DomainScaleFor = .uniformFit,
        @View3DBuilder content: () -> Content
    ) where Overlay == EmptyView3D {
        self.init(
            domain: domain,
            domainPadding: domainPadding,
            gridScaleFor: gridScaleFor,
            content: content,
            overlay: { _ in EmptyView3D() }
        )
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        let size = AspectRatioMath.scaledToFit(
            proposed.sizeOrDefault,
            aspectRatio: domain.padded(domainPadding).size,
            maxScale: nil
        )
        return size
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let domainScale = gridScaleFor(domain: domain, domainPadding: domainPadding, size: size)

        let domainContent = content
            .frame(size: domain.size)
            .padding(domainPadding)
            .scale(domainScale.scale)
            .renderWithSize(size, proposed, env)
            .translated(by: .init(domainScale.boundsPointFrom(domain: .zero)))

        return makeEntity(
            value: domainScale,
            children: domainContent,
            overlay(domainScale).renderWithSize(size, proposed, env)
        )
    }
}
