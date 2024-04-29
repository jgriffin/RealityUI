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

    public init(_ point1: Point3D, _ point2: Point3D, _ points: Point3D...) {
        self.points = [point1, point2] + points
    }

    func segments() -> [(id: Int, from: Vector3D, to: Vector3D)] {
        zip(points, points.dropFirst()).enumerated().map { offset, pair in
            (offset, Vector3D(pair.0), Vector3D(pair.1))
        }
    }

    func segmentViews() -> [any View3D] {
        segments().map { segment in
            _LineSegment3D(segment.to - segment.from)
                .offset(segment.from)
                .id(segment.id)
        }
    }

    public func customSizeFor(_: ProposedSize3D) -> Size3D {
        .zero
    }

    public func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        let children = segmentViews()
            .map { $0.render(context, size: size) }

        return makeEntity(
            value: points,
            children: children
        )
    }
}
