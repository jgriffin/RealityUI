//
// Created by John Griffin on 4/26/24
//

import RealityKit
import Spatial

public extension View3D {
    // core api
    func makeEntity(
        value: some Any,
        hideChildDescriptions: Bool = false,
        components: [any Component],
        children: [Entity]
    ) -> Entity {
        .make(
            .content(Self.self, value, hideChildDescriptions: hideChildDescriptions),
            components: components,
            children: children
        )
    }

    // MARK: - variadic

    // no component
    @inlinable func makeEntity(
        value: some Any,
        _ children: Entity...
    ) -> Entity {
        makeEntity(
            value: value,
            components: [],
            children: children
        )
    }

    // variadic children
    @inlinable func makeEntity(
        value: some Any,
        component: any Component,
        _ children: Entity...
    ) -> Entity {
        makeEntity(
            value: value,
            components: [component],
            children: children
        )
    }

    // double variadic
    @inlinable func makeEntity(
        value: some Any,
        components: (any Component)...,
        children: Entity...
    ) -> Entity {
        makeEntity(
            value: value,
            components: components,
            children: children
        )
    }
}
