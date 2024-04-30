//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - Shape

public protocol Shape3DStyle: View3D {
    var name: String { get }
    func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D
    func mesh(in size: Size3D) -> MeshResource
}

public extension Shape3DStyle {
    var body: some View3D {
        Shape3DView(shape: self)
    }
}

public struct Shape3DView<S: Shape3DStyle>: View3D, CustomView3D {
    public var shape: S

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        shape.shapeSizeFor(proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        let mesh = shape.mesh(in: customSizeFor(.init(size), context.environment))
        let material = context.environment.foregroundMaterial.makeMaterial()
        let materials = Array(repeating: material, count: mesh.expectedMaterialCount)
        let model = ModelComponent(mesh: mesh, materials: materials)

        return makeEntity(
            model
        )
    }
}
