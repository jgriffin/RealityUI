//
// Created by John Griffin on 5/1/24
//

import RealityUI
import Spatial

/// GridLInes, Ticks, Labels
public protocol Axis3DMark {
    associatedtype View3DBody: View3D

    @View3DBuilder
    func renderView(
        _ value: Axis3DValue,
        _ proxy: DimensionProxy,
        _ env: Chart3DEnvironment
    ) -> View3DBody
}

// MARK: - marks

public struct Axis3DGridLine: Axis3DMark {
    let centered: Bool?
    // let strokeStyle: StrokeStyle?

    public init(centered: Bool? = nil) {
        self.centered = centered
    }

    @View3DBuilder
    public func renderView(
        _ value: Axis3DValue,
        _ proxy: DimensionProxy,
        _: Chart3DEnvironment
    ) -> some View3D {
        if let o = proxy.othogonalFor(value.value) {
            Line3D(o.min, o.max)
        }
    }
}

public struct Axis3DTick: Axis3DMark {
    let centered: Bool?
    let length: Length
    // let strokeStyle: StrokeStyle?

    public init(centered: Bool?, length: Length) {
        self.centered = centered
        self.length = length
    }

    public func renderView(
        _ value: Axis3DValue,
        _ proxy: DimensionProxy,
        _: Chart3DEnvironment
    ) -> some View3D {
        if let o = proxy.othogonalFor(value.value) {
            Line3D(o.min, o.max)
        }
    }

    public enum Length {
        case automatic,
             length(Double),
             label(extendBy: Double = 0),
             longestLabel(extendBy: Double = 0)
    }
}

// public struct Axis3DValueLabel: Axis3DMark {
////    init(_ titleKey: LocalizedStringKey, centered: Bool? = nil, anchor: UnitPoint? = nil, multiLabelAlignment: Alignment? = nil, collisionResolution: AxisValueLabelCollisionResolution = .automatic, offsetsMarks: Bool? = nil, orientation: AxisValueLabelOrientation = .automatic, horizontalSpacing: CGFloat? = nil, verticalSpacing: CGFloat? = nil) where Content == Text
// }
