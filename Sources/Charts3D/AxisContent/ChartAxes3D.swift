//
// Created by John Griffin on 5/1/24
//

import Charts
import RealityKit
import RealityUI
import Spatial

public struct ChartAxes3D<XC: Axis3DContent, YC: Axis3DContent, ZC: Axis3DContent>: Chart3DContent {
    let xContent: XC
    let yContent: YC
    let zContent: ZC

    public init(xContent: XC, yContent: YC, zContent: ZC) {
        self.xContent = xContent
        self.yContent = yContent
        self.zContent = zContent
    }

    public func plottableDomains() -> PlottableDomains {
        .init()
    }

    @View3DBuilder
    public func renderView(_ proxy: Chart3DProxy, _ env: Chart3DEnvironment) -> some View3D {
        if let dimensionProxy = dimensionProxiesFor(proxy) {
            Canvas3D {
                xContent.renderView(dimensionProxy.x, env: env)
                yContent.renderView(dimensionProxy.y, env: env)
                zContent.renderView(dimensionProxy.z, env: env)
            }
        } else {
            EmptyView3D()
        }
    }

    func dimensionProxiesFor(_: Chart3DProxy) -> (x: DimensionProxy, y: DimensionProxy, z: DimensionProxy)? {
        nil
    }
}

public struct DimensionProxy {
    let axis: Axis3D
    let proxy: Chart3DProxy

    let othogonal: (min: Point3D, max: Point3D)
    let postionRange: Range<Double>

    // MARK: - position and values

    func position(for p: some Plottable) -> Double? {
        switch axis {
        case .x: proxy.positionFor(x: p)
        case .y: proxy.positionFor(y: p)
        case .z: proxy.positionFor(z: p)
        default: nil
        }
    }

    func value<P: Plottable>(at position: Double, as: P.Type) -> P? {
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

    func othogonalForPosition(_ position: Double) -> (min: Point3D, max: Point3D) {
        let offset = axis.asVector * position
        return (othogonal.min + offset, othogonal.max + offset)
    }
}
