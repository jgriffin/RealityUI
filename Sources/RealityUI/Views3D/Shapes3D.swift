//
// Created by John Griffin on 4/21/24
//

import RealityKit
import Spatial

// MARK: - shapes

public struct Box3D: Shape3DStyle {
    public init() {}

    public var name = "Box"

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

public struct Sphere3D: Shape3DStyle {
    public init() {}

    public var name = "Sphere"

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        AspectRatioMath.scaledToFit(proposed.sizeOrDefault, aspectRatio: .one, maxScale: nil)
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateSphere(radius: Float(size.vector.min() / 2))
    }
}
