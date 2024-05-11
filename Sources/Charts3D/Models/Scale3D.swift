//
// Created by John Griffin on 5/10/24
//

import Charts

// MARK: - PlotDimension

public struct PlotDimension {
    let domain: any PlotDimensionScaling
    let position: any PlotDimensionScaling // Value == PlotPosition

    public func plotPositionOf(_ n: PlottableNumeric) -> PlotPosition? {
        guard let ratio = domain.ratioInOf(n),
              let position = position.numericAtRatio(ratio)
        else {
            return nil
        }
        return position
    }

    public func valueAt(_ p: PlotPosition) -> PlottableNumeric? {
        guard let ratio = position.ratioInOf(p),
              let value = domain.numericAtRatio(ratio)
        else {
            return nil
        }
        return value
    }

    public var domainNumericRange: PlottableNumericRange? {
        guard let min = domain.numericAtRatio(0),
              let max = domain.numericAtRatio(1) else { return nil }
        return min ... max
    }

    public var positionRange: PlottableNumericRange {
        guard let min = position.numericAtRatio(0),
              let max = position.numericAtRatio(1) else { return 0 ... 0 }
        return min ... max
    }
}

// A type that you can use to configure the range of a chart.
public protocol PlotDimensionScaling {
    func ratioInOf(_ n: PlottableNumeric) -> Double?
    func numericAtRatio(_ r: Double) -> PlottableNumeric?
}

public extension PlotDimensionScaling {}

// A concrete PlotDimensionRanging implementations for PlottableNumeric or PlotPosition)
public struct PlotDimensionScale: PlotDimensionScaling {
    let range: PlottableNumericRange

    public func ratioInOf(_ n: PlottableNumeric) -> Double? {
        guard let n = PlottableNumeric.from(n) else { return nil }
        return range.ratioOf(n)
    }

    public func numericAtRatio(_ r: Double) -> PlottableNumeric? {
        range.interpolate(r)
    }
}

// MARK: - domain scaling

// A type that you can use to configure the domain of a chart.
public protocol DomainScaling {
    func dimensionScaleFor(_ numericRange: PlottableNumericRange?) -> any PlotDimensionScaling
}

public extension DomainScaling {
    static func automatic(includesZero: Bool?, reversed: Bool? = false) -> Self where Self == AutomaticDomainScale {
        AutomaticDomainScale(includesZero: includesZero ?? true, reversed: reversed ?? false)
    }
    // static func automatic<DataValue>(includesZero: Bool?, reversed: Bool?, dataType: DataValue.Type, modifyInferredDomain: (inout [DataValue]) -> Void) -> AutomaticScaleDomain
}

public struct AutomaticDomainScale: DomainScaling {
    let includesZero: Bool
    let reversed: Bool

    public func dimensionScaleFor(_ numericRange: PlottableNumericRange?) -> any PlotDimensionScaling {
        var range: PlottableNumericRange = numericRange ?? 0 ... 1
        if includesZero == true {
            range = min(range.lowerBound, 0) ... max(0, range.upperBound)
        }

        return PlotDimensionScale(range: range)
    }
}

// public struct ExplicitDomain<Value: Plottable>: ScaleDomain

// MARK: - plot position scaling

// A type that configures the x-axis and y-axis values.
public protocol PlotPositionScaling {
    func dimensionScaleFor(_ numericRange: PlottableNumericRange) -> any PlotDimensionScaling
}

public extension PlotPositionScaling {
    static func plotDimension(startPadding: PlotPosition, endPadding: PlotPosition) -> Self where Self == PlotPositionScale {
        PlotPositionScale(startPadding: startPadding, endPadding: endPadding)
    }

    static func plotDimension(padding: PlotPosition) -> Self where Self == PlotPositionScale {
        PlotPositionScale(startPadding: padding, endPadding: padding)
    }
}

// A range that represents the plot area’s width or height.
public struct PlotPositionScale: PlotPositionScaling {
    let startPadding: PlotPosition
    let endPadding: PlotPosition

    public func dimensionScaleFor(_ numericRange: PlottableNumericRange) -> any PlotDimensionScaling {
        var numericRange = numericRange
        if (startPadding + endPadding) < (numericRange.upperBound - numericRange.lowerBound) {
            numericRange = (numericRange.lowerBound + startPadding) ... (numericRange.upperBound - endPadding)
        }
        return PlotDimensionScale(range: numericRange)
    }
}

// typealias ScaleType - category, date, linear, log, squareRoot, symmetricLog
