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
        Canvas3D {
            xContent.renderView(proxy.xDimensionProxy, env: env)
            yContent.renderView(proxy.yDimensionProxy, env: env)
            zContent.renderView(proxy.zDimensionProxy, env: env)
        }
    }
}
