//
// Created by John Griffin on 5/2/24
//

import Charts

public typealias NumericDimension = Double

// public extension Plottable {
//    func `as`<P: Plottable>(_: P.Type) -> P? {
//        P.fromPlottable(self)
//    }
// }

public extension Plottable {
    static func from(_ p: some Plottable) -> Self? where Self: BinaryFloatingPoint {
        if let v = (p as? Self) {
            return v
        } else if let f = p.primitivePlottable as? any BinaryFloatingPoint {
            return .init(f)
        } else if let i = p.primitivePlottable as? any BinaryInteger {
            return .init(i)
        } else {
            return nil
        }
    }

    static func from(_ p: some Plottable) -> Self? where Self: BinaryInteger {
        if let v = (p as? Self) {
            return v
        } else if let f = p.primitivePlottable as? any BinaryFloatingPoint {
            return .init(f)
        } else if let i = p.primitivePlottable as? any BinaryInteger {
            return .init(i)
        } else {
            return nil
        }
    }

    static func from(_ p: some Plottable) -> Self? where Self == String {
        if let v = (p as? Self) {
            return v
        } else if let s = p.primitivePlottable as? any StringProtocol {
            return .init(s)
        }
        return nil
    }

    @_disfavoredOverload
    static func from(_ p: some Plottable) -> Self? {
        (p as? Self)
    }
}

extension ClosedRange where Bound: FloatingPoint {
    func ratioOf(_ x: Bound) -> Bound? {
        guard !isEmpty else { return nil }
        return (x - lowerBound) / (upperBound - lowerBound)
    }

    func interpolate(_ ratio: Bound) -> Bound {
        lowerBound + ratio * (upperBound - lowerBound)
    }

    func lerp(_ x: Bound, in from: ClosedRange<Bound>) -> Bound? {
        from.ratioOf(x).map(interpolate)
    }
}
