//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public struct _FlexibleFrame3D<Content: View3D>: View3D, CustomView3D {
    let content: Content
    let minWidth: Double?
    let maxWidth: Double?
    let minHeight: Double?
    let maxHeight: Double?
    let alignment: Alignment3D

    private func newProposedSize(_ proposed: ProposedSize3D) -> ProposedSize3D {
        var p = proposed.sizeOrDefault

        if let minWidth, minWidth > p.width {
            p.width = minWidth
        }
        if let maxWidth, maxWidth < p.width {
            p.width = maxWidth
        }
        if let minHeight, minHeight > p.height {
            p.height = minHeight
        }
        if let maxHeight, maxHeight < p.height {
            p.height = maxHeight
        }

        return .init(p)
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        let newProposed = newProposedSize(proposed)
        let childSize = content.sizeThatFits(newProposed, env)

        var result = childSize
        if let minWidth {
            result.width = max(minWidth, min(result.width, newProposed.width!))
        }
        if let maxWidth {
            result.width = min(max(result.width, newProposed.width!), maxWidth)
        }
        if let minHeight {
            result.height = max(minHeight, min(result.height, newProposed.height!))
        }
        if let maxHeight {
            result.height = min(max(result.height, newProposed.height!), maxHeight)
        }
        return result
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let newProposed = newProposedSize(.init(proposed))
        let childSize = content.sizeThatFits(newProposed, env)

        return makeEntity(
            value: (),
            children: content
                .renderWithSize(childSize, proposed, env)
                .translated(toAlign: alignment, child: childSize, withParent: size)
        )
    }
}
