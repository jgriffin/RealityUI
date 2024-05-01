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

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let mesh = shape.mesh(in: customSizeFor(.init(size), env))
        let material = env.foregroundMaterial.makeMaterial()
        let materials = Array(repeating: material, count: mesh.expectedMaterialCount)
        let model = ModelComponent(mesh: mesh, materials: materials)

        return makeEntity(
            model
        )
    }
}

public struct AnyShapeStyle: Shape3DStyle {
    let shape: any Shape3DStyle

    public init(_ shape: some Shape3DStyle) {
        self.shape = shape
    }

    public var name: String { shape.name }

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        shape.shapeSizeFor(proposed)
    }

    public func mesh(in size: Size3D) -> MeshResource {
        shape.mesh(in: size)
    }
}
