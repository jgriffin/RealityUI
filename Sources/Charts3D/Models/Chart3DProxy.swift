//
// Created by John Griffin on 4/23/24
//

import Charts
import Spatial

public struct Chart3DProxy {
    let plotSize: Size3D
    let plottableDomains: PlottableDomains
}

public extension Chart3DProxy {
    func domainRange() -> (x: Range<Float>, y: Range<Float>, z: Range<Float>)? { nil }

    // MARK: - position

    func positionFor(_: (some Plottable, some Plottable, some Plottable)) -> Point3D? { nil }
    func positionFor(x _: some Plottable) -> Double? { nil }
    func positionFor(y _: some Plottable) -> Double? { nil }
    func positionFor(z _: some Plottable) -> Double? { nil }

    // MARK: - value

    func value<X, Y, Z>(atPosition _: (X, Y, Z), as _: (X, Y, Z).Type) -> (X, Y, Z)? { nil }
    func value<X>(atX _: Double, as _: X.Type) -> X? { nil }
    func value<Y>(atY _: Double, as _: Y.Type) -> Y? { nil }
    func value<Z>(atZ _: Double, as _: Z.Type) -> Z? { nil }
}
