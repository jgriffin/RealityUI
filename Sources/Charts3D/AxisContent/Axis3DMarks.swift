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

    public init(
        preset: Axis3DMarkPreset = .automatic,
        position: Axis3DMarkPosition = .automatic,
        values: Axis3DMarkValues,
        content: @escaping (Axis3DValue) -> Content
    ) {
        self.preset = preset
        self.position = position
        self.values = values
        self.content = content
    }

    func resolvedMarks(_ proxy: DimensionProxy) -> [(value: Axis3DValue, content: Content)] {
        values.resolvedIn(proxy).compactMap { value in
            (value, content(value))
        }
    }

    @View3DBuilder
    public func renderView(_ proxy: DimensionProxy, _ env: Chart3DEnvironment) -> some View3D {
        let marks = resolvedMarks(proxy)

        Canvas3D {
            ForEach3D(marks, id: \.value.index) { value, content in
                content.renderView(value, proxy, env)
            }
        }
    }
}

public enum Axis3DMarkPreset { case automatic, aligned, extended, inset }

public enum Axis3DMarkPosition { case automatic, bottom, leading, top, trailing }

public struct Axis3DMarkValues {
    public typealias ResolvedIn = (DimensionProxy) -> [Axis3DValue]
    public let resolvedIn: ResolvedIn

    public static func values(_ values: [some Plottable]) -> Self {
        self.init { _ in
            let numericValues = values.compactMap { NumericDimension.from($0) }

            return numericValues.enumerated().map { index, value in
                Axis3DValue(count: numericValues.count, index: index, value: value)
            }
        }
    }

    public static func strideBy<S: Plottable & Strideable>(
        stepSize stepValue: S,
        roundLowerBound _: Bool? = nil,
        roundUpperBound _: Bool? = nil
    ) -> Self where S == S.Stride {
        self.init { proxy in
            let range = proxy.positionRange
            guard let lowerValue = proxy.value(at: range.lowerBound, as: S.self),
                  let upperValue = proxy.value(at: range.upperBound, as: S.self)
            else {
                return []
            }
            let numericValues = Array(stride(from: lowerValue, through: upperValue, by: stepValue))

            return numericValues.enumerated().map { index, value in
                Axis3DValue(count: numericValues.count, index: index, value: value)
            }
        }
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
}

public struct Axis3DValue {
    public let count: Int
    public let index: Int
    public let value: any Plottable
}
