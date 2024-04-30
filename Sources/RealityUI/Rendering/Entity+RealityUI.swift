//
// Created by John Griffin on 4/25/24
//

import RealityKit
import Spatial

public extension Entity {
    // MARK: - entity

    static func make(
        _ content: some RealityContentProtocol,
        components: [any Component],
        children: [Entity] = []
    ) -> Entity {
        let entity = Entity()
        entity.name = String(content.type.description.prefix(50))
        entity.realityUI = .init(content)
        entity.components.set(components)
        entity.children.append(contentsOf: children)
        return entity
    }

    static func make(
        _ content: some RealityContentProtocol,
        _ components: any Component...,
        children: Entity...
    ) -> Entity {
        make(content, components: components, children: children)
    }

    func with(_ with: (Self) -> Void) -> Self {
        with(self)
        return self
    }

    func withComponents(_ components: any Component...) -> Self {
        with { $0.components.set(components) }
    }

    func withChildren(_ children: Entity...) -> Self {
        with { $0.children.append(contentsOf: children) }
    }

    func withChildren(_ children: [Entity]) -> Self {
        with { $0.children.append(contentsOf: children) }
    }
}

public extension Entity {
    static let realityUIComponentTypes: [any Component.Type] = [
        Transform.self,
        ModelComponent.self,
    ]
}

public extension Component where Self == ModelComponent {
    static func model(
        mesh: MeshResource,
        material: Material3D
    ) -> Self {
        ModelComponent(
            mesh: mesh,
            materials: Array(repeating: material.makeMaterial(), count: mesh.expectedMaterialCount)
        )
    }
}

public extension Component where Self == Transform {
    static func transform(_ affine: AffineTransform3D) -> Self {
        #if os(visionOS)
            let transform = RealityKit.Transform(affine)
        #else
            let cols = affine.matrix4x4.columns
            let floatMatrix = matrix_float4x4(columns: (.init(cols.0), .init(cols.1), .init(cols.2), .init(cols.3)))
            let transform = RealityKit.Transform(matrix: floatMatrix)
        #endif
        return transform
    }

    @inlinable static func transform(pose: Pose3D) -> Self {
        transform(AffineTransform3D(pose: pose))
    }

    static func translation(_ translation: Vector3D) -> Self {
        transform(AffineTransform3D(translation: translation))
    }
}
