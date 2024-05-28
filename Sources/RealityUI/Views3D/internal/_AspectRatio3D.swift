//
// Created by John Griffin on 4/20/24
//

import RealityKit
import Spatial

public struct _AspectRatio3D<Content: View3D>: View3D, CustomView3D {
    var content: Content
    var aspectRatio: Size3D?
    var maxScale: Double?
    var contentMode: ContentMode

    public init(
        content: Content,
        aspectRatio: Size3D?,
        maxScale: Double?,
        contentMode: ContentMode
    ) {
        self.content = content
        self.aspectRatio = aspectRatio
        self.maxScale = maxScale
        self.contentMode = contentMode
    }

    public var description: String {
        [
            "\(contentType)",
            aspectRatio.map { "aspectRatio: \($0)" },
            maxScale.map { "maxScale: \($0)" },
        ].compactMap { $0 }.joined(separator: " ")
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        let aspectRatio = AspectRatioMath.scaledToFit(
            aspectRatio ?? content.sizeThatFits(proposed, env),
            into: .one,
            maxScale: nil
        )

        let proposal: Size3D =
            switch contentMode {
            case .fit:
                AspectRatioMath.scaledToFit(
                    aspectRatio,
                    into: proposed.sizeOrInfinite,
                    maxScale: maxScale
                )

            case .fill:
                AspectRatioMath.scaledToFill(
                    aspectRatio,
                    into: proposed.sizeOrInfinite,
                    maxScale: maxScale
                )
            }

        return content.sizeThatFits(.init(proposal), env)
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let scale = AspectRatioMath.scaleToFit(size, into: proposed)
        let scaleSize = Size3D.one * min(scale, maxScale ?? .greatestFiniteMagnitude)

        return makeEntity(
            value: scale,
            component: .transform(AffineTransform3D(scale: scaleSize)),
            content.renderWithSize(size, proposed, env)
        )
    }
}
