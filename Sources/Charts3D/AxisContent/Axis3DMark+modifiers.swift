//
// Created by John Griffin on 5/1/24
//

import RealityUI
import Spatial

public extension Axis3DMark {
    // func font(_ font: Font?) -> some AxisMark3D { self }

    func foregroundMaterial(_: Material3D) -> some Axis3DMark { self }

    func offset(_: Size3D) -> some Axis3DMark { self }

    @inlinable func offset(x: Double = 0, y: Double = 0, z: Double = 0) -> some Axis3DMark {
        offset(.init(Vector3D(x: x, y: y, z: z)))
    }
}
