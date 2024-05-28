//
// Created by John Griffin on 5/23/24
//

import Algorithms
import RealityKit
import Spatial
import SwiftUI

public struct GridDots3D: View3D, CustomView3D {
    let gridScale: GridScale3D

    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        Stack3D {
            ForEach3D(gridPoints(), id: \.self) { point in
                Sphere3D()
                    .frame(size: .one * 0.01)
                    .offset(.init(point))
            }
            .foreground(.cyan60)
        }
        .renderWithSize(size, proposed, env)
    }

    func gridPoints() -> [Point3D] {
        let (domainX, domainY, domainZ) = (gridScale.domainX, gridScale.domainY, gridScale.domainZ)
        let xs = Array(stride(from: domainX.lowerBound, through: domainX.upperBound, by: 1))
        let ys = Array(stride(from: domainY.lowerBound, through: domainY.upperBound, by: 1))
        let zs = Array(stride(from: domainZ.lowerBound, through: domainZ.upperBound, by: 1))

        let domainPoints = product(product(xs, ys), zs).map { xy, z in
            Point3D(x: xy.0, y: xy.1, z: z)
        }
        let points = domainPoints.map(gridScale.boundsPointFrom)
        return points
    }
}

#if os(visionOS)

    #Preview {
        RealityUIView {
            Geometry3DReader { size in
                let gridScale = GridScaleFor.uniformFit()(
                    domain: Rect3D(center: .zero, size: .one * 2),
                    size: size
                )
//                Box3D()
//                    .frame(size: gridScale.bounds.size)
                GridDots3D(gridScale: gridScale)
            }
            .border()
        }
    }

#endif
