//
// Created by John Griffin on 4/21/24
//

import RealityUI

public protocol PlottableMark {}

// MARK: - PointMark

public struct PointMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, CustomChartContent {
    public let point: (x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>)

    public init(_ point: (x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>)) {
        self.point = point
    }

    public init(x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>) {
        point = (x, y, z)
    }

    public init(_ labels: (x: String, y: String, z: String), _ point: (x: X, y: Y, z: Z)) {
        self.init(
            x: .value(labels.x, point.x),
            y: .value(labels.y, point.y),
            z: .value(labels.z, point.z)
        )
    }

    // MARK: - CustomChartContent

    public func customPlottableDomains() -> PlottableDomains {
        PlottableDomains(x: point.x, y: point.y, z: point.z)
    }

    public func customRender(_ env: ChartEnvironment) -> AnyRealityContent {
        env.symbolShape
            .environment(\.foregroundMaterial, env.foregroundMaterial)
            .frame(size: env.symbolSize)
            .eraseToAnyReality()
    }
}

// MARK: - LineMark

public struct LineMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, CustomChartContent {
    public let point: (x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>)

    public init(_ point: (x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>)) {
        self.point = point
    }

    public init(x: PlottableValue<X>, y: PlottableValue<Y>, z: PlottableValue<Z>) {
        point = (x, y, z)
    }

    public init(_ labels: (x: String, y: String, z: String), _ point: (x: X, y: Y, z: Z)) {
        self.init(
            x: .value(labels.x, point.x),
            y: .value(labels.y, point.y),
            z: .value(labels.z, point.z)
        )
    }

    // MARK: - CustomChartContent

    public func customPlottableDomains() -> PlottableDomains {
        PlottableDomains(x: point.x, y: point.y, z: point.z)
    }

    public func customRender(_ env: ChartEnvironment) -> AnyRealityContent {
        env.symbolShape
            .environment(\.foregroundMaterial, env.lineMaterial)
            .eraseToAnyReality()
    }
}

// MARK: - BoxMark

// public struct BoxMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, ChartCustomContent {
//    let min, max: PlottableValuePoint<X, Y, Z>
//
//    // MARK: - convenience intializers
//
//    public init(_ points: PlottableValuePoint<X, Y, Z>...) {
//        let xValues = points.map(\.x)
//        let yValues = points.map(\.y)
//        let zValues = points.map(\.z)
//    }
//
//    // MARK: - CustomChartContent
//
//    public func customPlottableDomains() -> PlottableDomains {
//        PlottableDomains(
//            x: min.x, max.x,
//            y: min.y, max.y,
//            z: min.z, max.z
//        )
//    }
//
//    public func customRender(_ env: ChartEnvironment) -> any RealityContent {
//        Box()
//            // size
//            // position
//            // material
//    }
// }

// MARK: - BarMark

// public struct BarMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, ChartBuiltIn {
//    let size: PlottableValueSize<X, Y, Z>
//
//    public init(_ size: PlottableValueSize<X, Y, Z>) {
//        self.size = size
//    }
//
//    public init(width: PlottableValue<X>, height: PlottableValue<Y>, depth: PlottableValue<Z>) {
//        self.init(.init(width: width, height: height, depth: depth))
//    }
//
//    public func customDimensionDomains() -> DimensionDomains {
//        DimensionDomains(
//            x: .init(size.width),
//            y: .init(size.height),
//            z: .init(size.depth)
//        )
//    }
//
//    public func customRender() {}
// }
