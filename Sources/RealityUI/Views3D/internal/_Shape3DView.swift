//
// Created by John Griffin on 5/28/24
//

import RealityKit
import Spatial
import SwiftUI

public struct Shape3DView<S: Shape3DStyle>: View3D, CustomView3D {
    public var shape: S

    public var description: String {
        "\(contentType)"
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        shape.shapeSizeFor(proposed)
    }

    public func customRenderWithSize(_ size: Size3D, _: Size3D, _ env: Environment3D) -> Entity {
        let shapeSize = customSizeFor(.init(size), env)
        let mesh = shape.mesh(in: shapeSize)
        let material = env.foregroundMaterial.makeMaterial()
        let materials = Array(repeating: material, count: mesh.expectedMaterialCount)
        let model = ModelComponent(mesh: mesh, materials: materials)

        return makeEntity(
            value: shape,
            component: model
        )
    }
}
