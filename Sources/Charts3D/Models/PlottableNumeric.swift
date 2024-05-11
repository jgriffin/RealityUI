//
// Created by John Griffin on 5/10/24
//

import Charts

public typealias PlottableNumeric = Double
public typealias PlotPosition = Double

public typealias PlottableNumericRange = ClosedRange<PlottableNumeric>
public typealias PlottableNumericRanges = (x: PlottableNumericRange?, y: PlottableNumericRange?, z: PlottableNumericRange?)

extension ClosedRange where Bound: FloatingPoint {
    func ratioOf(_ x: Bound) -> Bound? {
        guard (upperBound - lowerBound) != 0 else { return lowerBound }
        return (x - lowerBound) / (upperBound - lowerBound)
    }

    func interpolate(_ ratio: Bound) -> Bound {
        lowerBound + ratio * (upperBound - lowerBound)
    }

    func lerp(_ x: Bound, in from: ClosedRange<Bound>) -> Bound? {
        from.ratioOf(x).map(interpolate)
    }
}
