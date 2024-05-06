//
// Created by John Griffin on 4/23/24
//

import Charts
import Spatial

public struct Chart3DProxy {
    public let plotSize: Size3D
    public let domains: PlottableDomains
    public let xDomainNumeric: ClosedRange<NumericDimension>?
    public let yDomainNumeric: ClosedRange<NumericDimension>?
    public let zDomainNumeric: ClosedRange<NumericDimension>?

    public init(plotSize: Size3D, domains: PlottableDomains) {
        self.plotSize = plotSize
        self.domains = domains
        xDomainNumeric = domains.xNumeric
        yDomainNumeric = domains.yNumeric
        zDomainNumeric = domains.zNumeric
    }
}

public extension Chart3DProxy {
    typealias Position = Double

    // MARK: - position

    func positionFor(_ point: (x: some Plottable, y: some Plottable, z: some Plottable)) -> Point3D? {
        guard let x = positionFor(x: point.x),
              let y = positionFor(y: point.y),
              let z = positionFor(z: point.z) else { return nil }
        return Point3D(x: x, y: y, z: z)
    }

    func positionFor(x: some Plottable) -> Position? {
        guard let x = NumericDimension.from(x), let xDomainNumeric else { return nil }
        return xDomainNumeric.ratioOf(x).map { Position($0) * plotSize.width }
    }

    func positionFor(y: some Plottable) -> Position? {
        guard let y = NumericDimension.from(y), let yDomainNumeric else { return nil }
        return yDomainNumeric.ratioOf(y).map { Position($0) * plotSize.height }
    }

    func positionFor(z: some Plottable) -> Position? {
        guard let z = NumericDimension.from(z), let zDomainNumeric else { return nil }
        return zDomainNumeric.ratioOf(z).map { Position($0) * plotSize.depth }
    }

    // MARK: - value

    func value<X: Plottable, Y: Plottable, Z: Plottable>(
        atPosition position: (x: Position, y: Position, z: Position),
        as _: (x: X, y: Y, z: Z).Type
    ) -> (x: X, y: Y, z: Z)? {
        guard let x = value(atX: position.x, as: X.self),
              let y = value(atX: position.x, as: Y.self),
              let z = value(atX: position.x, as: Z.self) else { return nil }
        return (x, y, z)
    }

    func value<X: Plottable>(atX position: Position, as _: X.Type) -> X? {
        guard let d = xDomainNumeric?.lerp(position, in: 0 ... plotSize.width) else { return nil }
        return X.from(d)
    }

    func value<Y: Plottable>(atY position: Double, as _: Y.Type) -> Y? {
        guard let d = yDomainNumeric?.lerp(position, in: 0 ... plotSize.height) else { return nil }
        return Y.from(d)
    }

    func value<Z: Plottable>(atZ position: Double, as _: Z.Type) -> Z? {
        guard let d = zDomainNumeric?.lerp(position, in: 0 ... plotSize.depth) else { return nil }
        return Z.from(d)
    }

    // MARK: - dimension proxies

    var xDimensionProxy: DimensionProxy { DimensionProxy(axis: .x, proxy: self) }
    var yDimensionProxy: DimensionProxy { DimensionProxy(axis: .y, proxy: self) }
    var zDimensionProxy: DimensionProxy { DimensionProxy(axis: .z, proxy: self) }
}

public struct DimensionProxy {
    typealias Position = Chart3DProxy.Position

    let axis: Axis3D
    let proxy: Chart3DProxy

    let positionRange: ClosedRange<Position>
    let othogonal: (min: Point3D, max: Point3D)

    init(
        axis: Axis3D,
        proxy: Chart3DProxy
    ) {
        self.axis = axis
        self.proxy = proxy

        switch axis {
        case .x:
            positionRange = 0 ... proxy.plotSize.width
            othogonal = (min: .zero, max: .bottomLeadingFront)
        case .y:
            positionRange = 0 ... proxy.plotSize.height
            othogonal = (min: .zero, max: .topLeadingBack)
        case .z:
            positionRange = 0 ... proxy.plotSize.depth
            othogonal = (min: .zero, max: .bottomTrailingBack)
        default:
            positionRange = 0 ... 0
            othogonal = (min: .zero, max: .zero)
        }
    }

    // MARK: - position and values

    func position(for p: some Plottable) -> Position? {
        switch axis {
        case .x: proxy.positionFor(x: p)
        case .y: proxy.positionFor(y: p)
        case .z: proxy.positionFor(z: p)
        default: nil
        }
    }

    func value<P: Plottable>(at position: Position, as _: P.Type) -> P? {
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

    func othogonalForPosition(_ position: Position) -> (min: Point3D, max: Point3D) {
        let offset = axis.asVector * position
        return (othogonal.min + offset, othogonal.max + offset)
    }
}
