//
// Created by John Griffin on 4/21/24
//

import RealityUI
import Spatial

public extension Chart3DContent {
    func environment<V>(_ keyPath: WritableKeyPath<Chart3DEnvironment, V>, value: V) -> some Chart3DContent {
        _Environment3DModifier(self, keyPath, value)
    }

//    func foregroundMaterial(_ m: RealityUIMaterial) -> some ChartContent {
//        ChartEnvironmentModifier(self, \.foregroundMaterial, m)
//    }
//
//    func lineMaterial(_ m: RealityMaterial) -> some ChartContent {
//        ChartEnvironmentModifier(self, \.lineMaterial, m)
//    }
//
//    func symbol(_ s: some RealityShapeStyle) -> some ChartContent {
//        ChartEnvironmentModifier(self, \.symbolShape, s)
//    }
//
//    func symbolSize(_ size: Size3D) -> some ChartContent {
//        ChartEnvironmentModifier(self, \.symbolSize, size)
//    }

//    func opacity(Double) -> some ChartContent
//    func cornerRadius(CGFloat, style: RoundedCornerStyle) -> some ChartContent
//    func lineStyle(StrokeStyle) -> some ChartContent
//    func offset(CGSize) -> some ChartContent
//
//    func alignsMarkStylesWithPlotArea(Bool) -> some ChartContent
//
//    func symbol<S>(S) -> some ChartContent
//    func symbol<V>(symbol: () -> V) -> some ChartContent
//    func symbolSize(CGSize) -> some ChartContent
//    func symbolSize(CGFloat) -> some ChartContent
}
