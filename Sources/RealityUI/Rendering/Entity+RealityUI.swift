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

    @inlinable static func make(
        _ content: some RealityContentProtocol,
        _ components: any Component...,
        children: Entity...
    ) -> Entity {
        make(content, components: components, children: children)
    }

    func translated(_ offset: Vector3D) -> Entity {
        let before = AffineTransform3D(transform.matrix) ?? .identity
        let after = before.translated(by: offset)
        transform = .init(after)
        return self
    }

    func aligned(_ alignment: Alignment3D, parent: Size3D, child: Size3D) -> Entity {
        translated(alignment.offset(parent: parent, child: child))
    }
}

public extension Entity {
    static let realityUIComponentTypes: [any Component.Type] = [
        Transform.self,
        ModelComponent.self,
    ]

    var description: String {
        dump().joined(separator: "\n")
    }

    func dump() -> [String] {
        guard let realityUI else { return ["non-realityUI"] }

        let e = [realityUI.description, transformDescription]
            .compactMap { $0 }.joined(separator: " ")
        let c = realityUI.content.hideChildDescriptions ? [] :
            children.flatMap { $0.dump() }.map { "    \($0)" }
        return [e] + c
    }

    var transformDescription: String? {
        guard transform != .identity else { return nil }

        return [
            transform.translation == .zero ? nil : "translation: \(transform.translation)",
            transform.scale == .one ? nil : "scale: \(transform.scale)",
            transform.rotation.angle == 0 ? nil : "rotatation angle: \(transform.rotation.angle) axis: \(transform.rotation.axis)",
        ].compactMap { $0 }.joined(separator: " ")
    }
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
