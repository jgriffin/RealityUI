//
// Created by John Griffin on 4/26/24
//

import RealityKit

public extension RealityContent {
    // core api
    func makeEntity(
        value: some Any,
        components: [any Component],
        children: [Entity]
    ) -> Entity {
        .make(
            .value(Self.self, value),
            components: components,
            children: children
        )
    }

    // no value
    @inlinable func makeEntity(
        components: [any Component],
        children: [Entity]
    ) -> Entity {
        makeEntity(
            value: (),
            components: components,
            children: children
        )
    }

    // MARK: - variadic

    // variadic components
    @inlinable func makeEntity(
        value: some Any,
        _ components: (any Component)...,
        children: [Entity] = []
    ) -> Entity {
        makeEntity(
            value: value,
            components: components,
            children: children
        )
    }

    // double variadic
    @inlinable func makeEntity(
        value: some Any,
        _ components: (any Component)...,
        children: Entity...
    ) -> Entity {
        makeEntity(
            value: value,
            components: components,
            children: children
        )
    }

    // no Value variadic components
    @inlinable func makeEntity(
        _ components: (any Component)...,
        children: [Entity] = []
    ) -> Entity {
        makeEntity(
            components: components,
            children: children
        )
    }

    // no Value double variadic
    @inlinable func makeEntity(
        _ components: (any Component)...,
        children: Entity...
    ) -> Entity {
        makeEntity(
            components: components,
            children: children
        )
    }
}
