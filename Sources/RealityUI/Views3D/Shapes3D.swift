//
// Created by John Griffin on 4/21/24
//

import RealityKit
import Spatial

// MARK: - shapes

public struct Box3D: Shape3DStyle {
    public init() {}

    public var name = "Box3D"

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateBox(width: Float(size.width), height: Float(size.height), depth: Float(size.depth))
    }
}

public struct Sphere3D: Shape3DStyle {
    public init() {}

    public var name = "Sphere3D"

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        AspectRatioMath.scaledToFit(proposed.sizeOrDefault, aspectRatio: .one, maxScale: nil)
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateSphere(radius: Float(size.vector.min() / 2))
    }
}

public struct Cylinder3D: Shape3DStyle {
    public init() {}

    public var name = "Cylinder3D"

    public func shapeSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        var size = proposed.sizeOrDefault
        if size.width < size.depth {
            size.width = size.depth
        } else {
            size.depth = size.width
        }
        return size
    }

    public func mesh(in size: Size3D) -> MeshResource {
        .generateCylinder(
            height: Float(size.height),
            radius: Float(min(size.width, size.depth) / 2)
        )
    }
}
