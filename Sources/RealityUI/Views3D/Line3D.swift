//
// Created by John Griffin on 4/28/24
//

import RealityGeometries
import RealityKit
import Spatial
import SwiftUI

public struct Line3D: View3D, CustomView3D {
    public let points: [Point3D]

    public init(_ points: [Point3D]) {
        self.points = points
    }

    public init(_ points: Point3D...) {
        self.points = points
    }

    // MARK: - segments

    static let defaultDirection = Point3D(.right)

    struct Segment {
        let id: Int
        let from: Vector3D
        let to: Vector3D
    }

    func segmentsFromPoints() -> [Segment]? {
        guard points.count > 1 else { return nil }
        return zip(points, points.dropFirst()).enumerated().map { offset, pair in
            Segment(id: offset, from: Vector3D(pair.0), to: Vector3D(pair.1))
        }
    }

    // extend in a direction, through the size
    func segmentInSize(_ size: Size3D, direction: Point3D?) -> Segment {
        let direction = Vector3D(direction ?? Self.defaultDirection)
        let scale = AspectRatioMath.scaleToFit(.init(direction), into: size)
        let scaledDirection = direction * scale

        return Segment(
            id: 0,
            from: -(scaledDirection / 2),
            to: scaledDirection / 2
        )
    }

    func viewsForSegments(_ segments: [Segment]) -> [any View3D] {
        segments.map { segment in
            _LineSegment3D(from: segment.from, to: segment.to)
                .id(segment.id)
        }
    }

    // MARK: - CustomView3D

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        guard points.count < 2 else {
            // pointed lines have no size
            return .zero
        }

        // otherwise, extend in a direction, through the space
        let segment = segmentInSize(proposed.sizeOrDefault, direction: points.first)
        return .init(segment.to - segment.from).union(.one * 2 * env.lineRadius)
    }

    public func customRenderWithSize(_ size: Size3D, _: Size3D, _ env: Environment3D) -> Entity {
        let radius = env.lineRadius
        let material = env.foregroundMaterial.makeMaterial()
        let segments = segmentsFromPoints() ?? [segmentInSize(size, direction: points.first)]

        let children = segments.map { segment in
            makeSegmentEntity(
                from: segment.from,
                to: segment.to,
                lineRadius: radius,
                material: material
            )
        }

        return makeEntity(
            value: points,
            hideChildDescriptions: true,
            components: [],
            children: children
        )
    }

    private func makeSegmentEntity(
        from: Vector3D,
        to: Vector3D,
        lineRadius radius: Double,
        material: some RealityKit.Material
    ) -> Entity {
        let length = (to - from).length
        let middle = (from + to) / 2

        let mesh = try! RealityGeometry.generateCylinder(radius: Float(radius), height: Float(length))
        let materials = Array(repeating: material, count: mesh.expectedMaterialCount)
        let model = ModelComponent(mesh: mesh, materials: materials)

        let rotation = Vector3D.up.rotation(to: to - middle)
        let pose = Pose3D(position: .init(middle), rotation: rotation)

        return makeEntity(
            value: (from, to),
            components: model, .transform(pose: pose)
        )
    }
}

public extension Line3D {
    static let boxPoints = [
        Vector3D.bottomLeadingFront, .bottomTrailingFront, .topTrailingFront, .topLeadingFront,
        .topLeadingBack, .topTrailingBack, .bottomTrailingBack, .bottomLeadingBack,
        .bottomLeadingFront,
    ].map { Point3D($0 * 0.2) }
}
