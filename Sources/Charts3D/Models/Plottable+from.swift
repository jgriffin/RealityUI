//
// Created by John Griffin on 5/2/24
//

import Charts

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
