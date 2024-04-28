//
// Created by John Griffin on 4/23/24
//

import Spatial

public struct ChartProxy {
    let plotSize: Size3D
    let plottableDomains: PlottableDomains
}

public extension ChartProxy {
    // MARK: - position

    func position(for _: (some Plottable, some Plottable, some Plottable)) -> Point3D? { nil }
    func position(forX _: some Plottable) -> Double? { nil }
    func position(forY _: some Plottable) -> Double? { nil }
    func position(forZ _: some Plottable) -> Double? { nil }

    // MARK: - value

    func value<X, Y, Z>(atPosition _: (X, Y, Z), as _: (X, Y, Z).Type) -> (X, Y, Z)? { nil }
    func value<X>(atX _: Double, as _: X.Type) -> X? { nil }
    func value<Y>(atY _: Double, as _: Y.Type) -> Y? { nil }
    func value<Z>(atZ _: Double, as _: Z.Type) -> Z? { nil }
}
