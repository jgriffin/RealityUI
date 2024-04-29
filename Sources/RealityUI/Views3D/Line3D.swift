//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

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

    public func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        guard points.count < 2 else {
            // pointed lines have no size
            return .zero
        }

        // otherwise, extend in a direction, through the space
        let segment = segmentInSize(proposed.sizeOrDefault, direction: points.first)
        // TODO: line width
        return .init(segment.to - segment.from)
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        let segments = segmentsFromPoints() ?? [segmentInSize(size, direction: points.first)]
        let children = viewsForSegments(segments).map {
            $0.render(context, size: .zero)
        }

        return makeEntity(value: points, children: children)
    }

    static let boxPoints = [
        Vector3D.bottomLeadingFront, .bottomTrailingFront, .topTrailingFront, .topLeadingFront,
        .topLeadingBack, .topTrailingBack, .bottomTrailingBack, .bottomLeadingBack,
        .bottomLeadingFront,
    ].map { Point3D($0 * 0.2) }
}
