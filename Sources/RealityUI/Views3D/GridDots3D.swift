//
// Created by John Griffin on 5/23/24
//

import Algorithms
import RealityKit
import Spatial
import SwiftUI

public struct GridDots3D: View3D, CustomView3D {
    let gridScale: DomainScale3D

    public init(gridScale: DomainScale3D) {
        self.gridScale = gridScale
    }

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        Stack3D {
            ForEach3D(gridPoints(), id: \.self) { point in
                Sphere3D()
                    .frame(size: .one * 0.005)
                    .offset(.init(point))
            }
            .foreground(.cyan60)
        }
        .renderWithSize(size, proposed, env)
    }

    func gridPoints() -> [Point3D] {
        let xs = Array(stride(from: gridScale.domain.min.x, through: gridScale.domain.max.x, by: 1))
        let ys = Array(stride(from: gridScale.domain.min.y, through: gridScale.domain.max.y, by: 1))
        let zs = Array(stride(from: gridScale.domain.min.z, through: gridScale.domain.max.z, by: 1))

        let domainPoints = product(product(xs, ys), zs).map { xy, z in
            Point3D(x: xy.0, y: xy.1, z: z)
        }
        let points = domainPoints.map(gridScale.boundsPointFrom)
        return points
    }
}
