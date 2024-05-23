//
// Created by John Griffin on 5/22/24
//

import Foundation

public typealias DoubleRange = ClosedRange<Double>

public extension ClosedRange where Bound: FloatingPoint {
    func ratioOf(_ x: Bound) -> Bound {
        guard (upperBound - lowerBound) != 0 else { return lowerBound }
        return (x - lowerBound) / (upperBound - lowerBound)
    }

    func interpolate(_ ratio: Bound) -> Bound {
        lowerBound + ratio * (upperBound - lowerBound)
    }

    func lerp(_ x: Bound, in from: ClosedRange<Bound>) -> Bound {
        interpolate(from.ratioOf(x))
    }
}
