//
// Created by John Griffin on 4/21/24
//

import Charts
import RealityUI

// MARK: - Point3DMark

public struct Point3DMark<X: Plottable, Y: Plottable, Z: Plottable>: Chart3DContent, CustomChart3DContent {
    public let point: (x: Plottable3DValue<X>, y: Plottable3DValue<Y>, z: Plottable3DValue<Z>)

    public init(_ point: (x: Plottable3DValue<X>, y: Plottable3DValue<Y>, z: Plottable3DValue<Z>)) {
        self.point = point
    }

    public init(x: Plottable3DValue<X>, y: Plottable3DValue<Y>, z: Plottable3DValue<Z>) {
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

    public func customRender(_ env: Chart3DEnvironment) -> AnyView3D {
        env.symbolShape
            .environment(\.foregroundMaterial, env.foregroundMaterial)
            .frame(size: env.symbolSize)
            .eraseToAnyReality()
    }
}

// MARK: - LineMark

public struct Line3DMark<X: Plottable, Y: Plottable, Z: Plottable>: Chart3DContent, CustomChart3DContent {
    public let point: (x: Plottable3DValue<X>, y: Plottable3DValue<Y>, z: Plottable3DValue<Z>)

    public init(_ point: (x: Plottable3DValue<X>, y: Plottable3DValue<Y>, z: Plottable3DValue<Z>)) {
        self.point = point
    }

    public init(x: Plottable3DValue<X>, y: Plottable3DValue<Y>, z: Plottable3DValue<Z>) {
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

    public func customRender(_ env: Chart3DEnvironment) -> AnyView3D {
        env.symbolShape
            .environment(\.foregroundMaterial, env.lineMaterial)
            .eraseToAnyReality()
    }
}

// MARK: - BoxMark

// public struct BoxMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, ChartCustomContent {
//    let min, max: Plottable3DValuePoint<X, Y, Z>
//
//    // MARK: - convenience intializers
//
//    public init(_ points: Plottable3DValuePoint<X, Y, Z>...) {
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
//    public func customRender(_ env: ChartEnvironment) -> any View3D {
//        Box()
//            // size
//            // position
//            // material
//    }
// }

// MARK: - BarMark

// public struct BarMark<X: Plottable, Y: Plottable, Z: Plottable>: ChartContent, ChartBuiltIn {
//    let size: Plottable3DValueSize<X, Y, Z>
//
//    public init(_ size: Plottable3DValueSize<X, Y, Z>) {
//        self.size = size
//    }
//
//    public init(width: Plottable3DValue<X>, height: Plottable3DValue<Y>, depth: Plottable3DValue<Z>) {
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
