//
// Created by John Griffin on 5/1/24
//

import Spatial

public extension Axis3D {
    var vector: SIMD3<Double> {
        switch self {
        case .x: [1, 0, 0]
        case .y: [0, 1, 0]
        case .z: [0, 0, 1]
        default: [0, 0, 0]
        }
    }

    var asVector: Vector3D { Vector3D(vector) }

    func mix(onAxis: Vector3D, offAxis: Vector3D) -> Vector3D {
        Vector3D(vector * onAxis.vector + (.one - vector) * offAxis.vector)
    }
}
