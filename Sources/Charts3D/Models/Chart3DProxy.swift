//
// Created by John Griffin on 4/23/24
//

import Charts
import RealityUI
import Spatial

public struct Chart3DProxy {
    public let chartSize: Size3D
    public let domains: PlottableDomains
    public let dimension: (x: PlotDimension, y: PlotDimension, z: PlotDimension)

    public init(
        chartSize: Size3D,
        domains: PlottableDomains,
        domainScale: DomainScaling = .automatic(includesZero: false),
        positionScale: PlotPositionScaling = .plotDimension(padding: 0.05)
    ) {
        self.chartSize = chartSize
        self.domains = domains

        let numericDomains = domains.numericDomains
        dimension = (
            x: .init(
                domain: domainScale.dimensionScaleFor(numericDomains.x),
                position: positionScale.dimensionScaleFor(-chartSize.width / 2 ... chartSize.width / 2)
            ),
            y: .init(
                domain: domainScale.dimensionScaleFor(numericDomains.y),
                position: positionScale.dimensionScaleFor(-chartSize.height / 2 ... chartSize.height / 2)
            ),
            z: .init(
                domain: domainScale.dimensionScaleFor(numericDomains.z),
                position: positionScale.dimensionScaleFor(-chartSize.depth / 2 ... chartSize.depth / 2)
            )
        )
    }
}

public extension Chart3DProxy {
    func positionMinMax() -> (min: Point3D, max: Point3D) {
        (
            min: Point3D(x: dimension.x.positionRange.lowerBound,
                         y: dimension.y.positionRange.lowerBound,
                         z: dimension.z.positionRange.lowerBound),
            max: Point3D(x: dimension.x.positionRange.upperBound,
                         y: dimension.y.positionRange.upperBound,
                         z: dimension.z.positionRange.upperBound)
        )
    }

    // MARK: - position

    func positionFor(_ point: (x: some Plottable, y: some Plottable, z: some Plottable)) -> Point3D? {
        guard let x = positionFor(x: point.x),
              let y = positionFor(y: point.y),
              let z = positionFor(z: point.z) else { return nil }
        return Point3D(x: x, y: y, z: z)
    }

    func positionFor(x: some Plottable) -> PlotPosition? {
        guard let x = PlottableNumeric.from(x) else { return nil }
        return dimension.x.plotPositionOf(x)
    }

    func positionFor(y: some Plottable) -> PlotPosition? {
        guard let y = PlottableNumeric.from(y) else { return nil }
        return dimension.y.plotPositionOf(y)
    }

    func positionFor(z: some Plottable) -> PlotPosition? {
        guard let z = PlottableNumeric.from(z) else { return nil }
        return dimension.z.plotPositionOf(z)
    }

    // MARK: - value

    func value<X: Plottable, Y: Plottable, Z: Plottable>(
        atPosition position: (x: PlotPosition, y: PlotPosition, z: PlotPosition),
        as _: (x: X, y: Y, z: Z).Type
    ) -> (x: X, y: Y, z: Z)? {
        guard let x = value(atX: position.x, as: X.self),
              let y = value(atY: position.y, as: Y.self),
              let z = value(atZ: position.z, as: Z.self) else { return nil }
        return (x, y, z)
    }

    func value<X: Plottable>(atX position: PlotPosition, as _: X.Type) -> X? {
        guard let v = dimension.x.valueAt(position) else { return nil }
        return X.from(v)
    }

    func value<Y: Plottable>(atY position: Double, as _: Y.Type) -> Y? {
        guard let v = dimension.y.valueAt(position) else { return nil }
        return Y.from(v)
    }

    func value<Z: Plottable>(atZ position: Double, as _: Z.Type) -> Z? {
        guard let v = dimension.z.valueAt(position) else { return nil }
        return Z.from(v)
    }

    // MARK: - dimension proxies

    var xDimensionProxy: DimensionProxy { DimensionProxy(axis: .x, proxy: self) }
    var yDimensionProxy: DimensionProxy { DimensionProxy(axis: .y, proxy: self) }
    var zDimensionProxy: DimensionProxy { DimensionProxy(axis: .z, proxy: self) }
}

public struct DimensionProxy {
    let axis: Axis3D
    let proxy: Chart3DProxy

    let domainRange: PlottableNumericRange?
    let orthogonal: (min: Point3D, max: Point3D)

    init(
        axis: Axis3D,
        proxy: Chart3DProxy
    ) {
        self.axis = axis
        self.proxy = proxy

        let (pMin, pMax) = proxy.positionMinMax()

        switch axis {
        case .x:
            domainRange = proxy.dimension.x.domainNumericRange
            orthogonal = (
                min: Point3D(x: pMin.x, y: pMin.y, z: pMin.z),
                max: Point3D(x: pMin.x, y: pMin.y, z: pMax.z)
            )
        case .y:
            domainRange = proxy.dimension.y.domainNumericRange
            orthogonal = (
                min: Point3D(x: pMin.x, y: pMin.y, z: pMin.z),
                max: Point3D(x: pMax.x, y: pMin.y, z: pMin.z)
            )
        case .z:
            domainRange = proxy.dimension.z.domainNumericRange
            orthogonal = (
                min: Point3D(x: pMax.x, y: pMin.y, z: pMin.z),
                max: Point3D(x: pMax.x, y: pMax.y, z: pMin.z)
            )
        default:
            domainRange = nil
            orthogonal = (min: .zero, max: .zero)
        }
    }

    // MARK: - position and values

    func position(for p: some Plottable) -> PlotPosition? {
        switch axis {
        case .x: proxy.positionFor(x: p)
        case .y: proxy.positionFor(y: p)
        case .z: proxy.positionFor(z: p)
        default: nil
        }
    }

    func value<P: Plottable>(at position: PlotPosition, as _: P.Type) -> P? {
        switch axis {
        case .x: proxy.value(atX: position, as: P.self)
        case .y: proxy.value(atY: position, as: P.self)
        case .z: proxy.value(atZ: position, as: P.self)
        default: nil
        }
    }

    func othogonalFor(_ p: some Plottable) -> (min: Point3D, max: Point3D)? {
        guard let position = position(for: p) else { return nil }
        return othogonalForPosition(position)
    }

    func othogonalForPosition(_ position: PlotPosition) -> (min: Point3D, max: Point3D) {
        let min = axis.mix(onAxis: .init(x: position, y: position, z: position), offAxis: .init(orthogonal.min))
        let max = axis.mix(onAxis: .init(x: position, y: position, z: position), offAxis: .init(orthogonal.max))
        return (.init(min), .init(max))
    }
}
