//
// Created by John Griffin on 4/28/24
//

import Spatial

public struct CanvasLayout3D: Layout3D {
    public let alignment: Alignment3D

    public init(alignment: Alignment3D = .center) {
        self.alignment = alignment
    }

    public func sizeThatFitsContents(
        _ contents: [any View3D],
        proposal: ProposedSize3D,
        _ env: Environment3D
    ) -> Size3D {
        let sizes = contents.map { $0.sizeThatFits(proposal, env) }

        return sizes.reduce(.zero) { result, size in
            result.union(size)
        }
    }

    public func placeContents(
        _ contents: [any View3D],
        in size: Size3D,
        _ env: Environment3D
    ) -> [LayoutContentPlacement] {
        let proposed = ProposedSize3D(size)

        return contents.map { content -> LayoutContentPlacement in
            let size = content.sizeThatFits(proposed, env)

            return LayoutContentPlacement(
                content: content,
                size: size,
                position: .zero
            )
        }
    }
}
