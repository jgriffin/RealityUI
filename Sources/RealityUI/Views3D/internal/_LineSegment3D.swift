//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

public struct _LineSegment3D: View3D, CustomView3D {
    public let vector: Vector3D

    public init(_ vector: Vector3D) {
        self.vector = vector
    }

    public func customSizeFor(_: ProposedSize3D) -> Size3D {
        .init(vector)
    }

    public func customRender(_ context: RenderContext, size _: Size3D) -> Entity {
        let radius = context.environment.lineRadius
        let material = context.environment.foregroundMaterial.makeMaterial()

        let length = vector.length
        let middle = vector / 2

        let mesh = MeshResource.generateCylinder(height: Float(length), radius: Float(radius))
        let materials = Array(repeating: material, count: mesh.expectedMaterialCount)
        let model = ModelComponent(mesh: mesh, materials: materials)

        let rotation = Vector3D.up.rotation(to: vector)
        let pose = Pose3D(position: .init(middle), rotation: rotation)

        return makeEntity(
            value: vector,
            model,
            .transform(pose: pose)
        )
    }
}
