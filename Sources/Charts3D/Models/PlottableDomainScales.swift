//
// Created by John Griffin on 4/23/24
//

import Spatial

public struct PlotScales {
    let plotDomains: PlottableDomains
    let plotSize: Size3D
}

public extension PlotScales {
    func postion(forX _: some Plottable) -> Point3D? { nil }
    func postion(forY _: some Plottable) -> Point3D? { nil }
    func postion(forZ _: some Plottable) -> Point3D? { nil }

    func xDomain<P: Plottable>(dataType _: P.Type) -> [P] { [] }
    func yDomain<P: Plottable>(dataType _: P.Type) -> [P] { [] }
    func zDomain<P: Plottable>(dataType _: P.Type) -> [P] { [] }
}
