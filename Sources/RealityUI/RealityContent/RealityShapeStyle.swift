//
// Created by John Griffin on 4/18/24
//

import RealityKit
import Spatial

// MARK: - Shape

public protocol RealityShapeStyle: RealityContent {
    var name: String { get }
    func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D
    func mesh(in size: Size3D) -> MeshResource
}

public extension RealityShapeStyle {
    var body: some RealityContent {
        RealityShapeView(shape: self)
    }
}

public struct RealityShapeView<S: RealityShapeStyle>: RealityContent, CustomRealityContent {
    public var shape: S

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        shape.shapeSizeFor(proposed)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        let mesh = shape.mesh(in: customSizeFor(.init(size)))
        let material = context.environment.foregroundMaterial.makeMaterial()
        let materials = Array(repeating: material, count: mesh.expectedMaterialCount)
        let model = ModelComponent(mesh: mesh, materials: materials)

        return makeEntity(
            model
        )
    }
}
