//
// Created by John Griffin on 4/30/24
//

import Charts
import RealityUI
import Spatial

/// Represents a set of marks along an axis, e.g. grid lines OR tick marks
/// There can be multiple Axis3DMarks on the same axis
public struct Axis3DMarks<Content: Axis3DMark>: Axis3DContent {
    let preset: Axis3DMarkPreset
    let position: Axis3DMarkPosition
    let values: Axis3DMarkValues
    let content: (Axis3DValue) -> Content

    func resolvedMarks(_ proxy: DimensionProxy) -> [(value: Axis3DValue, content: Content)] {
        values.resolvedIn(proxy).compactMap { value in
            (value, content(value))
        }
    }

    @View3DBuilder
    public func renderView(_ proxy: DimensionProxy, env: Chart3DEnvironment) -> some View3D {
        let marks = resolvedMarks(proxy)
        ForEach3D(marks, id: \.value.index) { value, content in
            content.renderView(value, proxy, env)
        }
    }
}

public enum Axis3DMarkPreset { case automatic, aligned, extended, inset }

public enum Axis3DMarkPosition { case automatic, bottom, leading, top, trailing }

public struct Axis3DMarkValues {
    let resolvedIn: (_: DimensionProxy) -> [Axis3DValue]

    static func values(_: [some Plottable]) -> Self {
        fatalError()
    }

    static func desiredCount(desiredCount _: Int? = nil, roundLowerBound _: Bool? = nil, roundUpperBound _: Bool? = nil) -> Self {
        fatalError()
    }

    static func desiredMinimum(
        minimumStride _: some Plottable,
        desiredCount _: Int? = nil,
        roundLowerBound _: Bool? = nil,
        roundUpperBound _: Bool? = nil
    ) -> Self {
        fatalError()
    }

    static func strideBy(
        stepSize _: some Plottable,
        roundLowerBound _: Bool? = nil,
        roundUpperBound _: Bool? = nil
    ) -> Self {
        fatalError()
    }
}

public struct Axis3DValue {
    let count: Int
    let index: Int
    let value: any Plottable

    func `as`<P: Plottable>(_: P.Type) -> P? {
        value as? P
    }
}
