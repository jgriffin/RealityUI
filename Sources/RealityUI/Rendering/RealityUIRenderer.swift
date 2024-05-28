//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

public class RealityUIRenderer {
    public let realityRoot: Entity

    public init() {
        RealityUIComponent.registerOnce
        realityRoot = EmptyView3D().makeEntity(value: "realityRoot")
    }

    public func update(
        with content: any View3D,
        size: Size3D
    ) {
        let renderTree = RealityUIRenderer.renderTreeFor(content, size: size)

        let existingRoot = realityRoot.children.first
        let updatedRoot = RealityUIRenderer.updatedRealityTree(existingRoot, withRenderRoot: renderTree)

        if existingRoot != updatedRoot {
            realityRoot.children.removeAll()
            realityRoot.children.append(updatedRoot)
        }
    }
}

extension RealityUIRenderer {
    /// returns a whole Entity tree independent of realityRoot
    static func renderTreeFor(
        _ content: any View3D,
        size: Size3D
    ) -> Entity {
        let env = Environment3D()
        let contentSize = content.sizeThatFits(.init(size), env)
        return content.renderWithSize(contentSize, size, env)
    }

    /// Recursive method that returns an updated reality tree
    ///
    /// It will try to re-use and update the existingRoot at each step, but may also return an entirelly different Entity tree,
    /// expecting the caller to remove it from its parent.
    static func updatedRealityTree(
        _ existingRoot: Entity?,
        withRenderRoot renderRoot: Entity
    ) -> Entity {
        // MARK: gotta be the same type to update

        guard let existingRoot,
              let existingContent = existingRoot.realityUI?.content,
              let renderContent = renderRoot.realityUI?.content,
              existingContent.type == renderContent.type
        else {
            // new entity tree
            return renderRoot
        }

        // We're going to update the existingRoot after here

        // MARK: components

        if !existingContent.isEqual(renderContent) {
            for componentType in Entity.realityUIComponentTypes {
                if let c = renderRoot.components[componentType.self] {
                    existingRoot.components[componentType] = c
                }
            }
        }

        // MARK: recursively updatedRealityTree for children

        let matchedChildren = bestMatch(
            renderChildren: renderRoot.children,
            toExistingSiblings: existingRoot.children
        )
        let updatedChildren = matchedChildren.map { render, existing in
            updatedRealityTree(existing, withRenderRoot: render)
        }

        // MARK: update existingRoot.children

        let previousChildIds = Set(existingRoot.children.map(\.id))
        let updatedIds = Set(updatedChildren.map(\.id))
        let removeChildIds = previousChildIds.subtracting(updatedIds)
        let addChildIds = updatedIds.subtracting(previousChildIds)

        if !removeChildIds.isEmpty {
            existingRoot.children.filter { removeChildIds.contains($0.id) }.forEach {
                existingRoot.removeChild($0)
            }
        }
        if !addChildIds.isEmpty {
            updatedChildren.filter { addChildIds.contains($0.id) }.forEach {
                existingRoot.addChild($0)
            }
        }

        return existingRoot
    }

    /// try and match render with existing siblings for better animation and performance
    ///
    /// In order to match, the RealityContentTypes need to be the same. All the renderChildren will be returned once,
    /// existing siblings at most once, and the match can be nil. The rest is optimization.
    static func bestMatch(
        renderChildren: Entity.ChildCollection,
        toExistingSiblings siblings: Entity.ChildCollection
    ) -> [(render: Entity, match: Entity?)] {
        // try simple for now
        var existing = siblings.map { $0 }

        return renderChildren.map { render -> SiblingMatch in
            guard let rType = render.realityUI?.content.type,
                  let matchIndex = existing.firstIndex(where: { $0.realityUI?.content.type == rType })
            else {
                return (render, match: nil)
            }

            let match = existing.remove(at: matchIndex)
            return (render, match)
        }
    }

    typealias SiblingMatch = (render: Entity, match: Entity?)
}
