//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

struct _LineSegment3D: View3D, CustomView3D {
    let from: Vector3D
    let to: Vector3D

    init(from: Vector3D, to: Vector3D) {
        self.from = from
        self.to = to
    }

    func customSizeFor(_: ProposedSize3D, _: Environment3D) -> Size3D {
        .zero
    }

    func customRender(_ context: RenderContext, size _: Size3D) -> Entity {
        let radius = context.environment.lineRadius
        let material = context.environment.foregroundMaterial.makeMaterial()

        let length = (to - from).length
        let middle = (from + to) / 2

        let mesh = MeshResource.generateCylinder(height: Float(length), radius: Float(radius))
        let materials = Array(repeating: material, count: mesh.expectedMaterialCount)
        let model = ModelComponent(mesh: mesh, materials: materials)

        let rotation = Vector3D.up.rotation(to: to - middle)
        let pose = Pose3D(position: .init(middle), rotation: rotation)

        return makeEntity(
            value: (from, to),
            model,
            .transform(pose: pose)
        )
    }
}
