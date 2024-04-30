//
// Created by John Griffin on 4/30/24
//

import RealityUI
import Spatial

public struct AxisMarks3D {
//    init(format: some Any, preset: AxisMark3DPreset, position: AxisMark3DPosition, values: AxisMark3DValues, stroke: StrokeStyle3D?) {}
//
//    init(format: some Any, preset: AxisMark3DPreset, position: AxisMark3DPosition, values: [some Any], stroke: StrokeStyle3D?) {}
//
//    init(preset: AxisMark3DPreset, position: AxisMark3DPosition, values: [some Any], content: (AxisValue) -> Content)
//
//    init(preset: AxisMark3DPreset, position: AxisMark3DPosition, values: [some Any], content: () -> Content)
//
//    init(preset: AxisMark3DPreset, position: AxisMark3DPosition, values: AxisMark3DValues, content: () -> Content)
//
//    init(preset: AxisMark3DPreset, position: AxisMark3DPosition, values: AxisMark3DValues, content: (AxisValue) -> Content)
//
//    init(preset: AxisMark3DPreset, position: AxisMark3DPosition, values: AxisMark3DValues, stroke: StrokeStyle3D?)
//
//    init(preset: AxisMark3DPreset, position: AxisMark3DPosition, values: [some Plottable], stroke: StrokeStyle3D?)

    public func customPlottableDomains() -> PlottableDomains {
        .init()
    }

    public func customRender(_: Chart3DEnvironment) -> AnyView3D {
        EmptyView3D().eraseToAnyReality()
    }
}

public enum AxisMark3DPreset {
    case automatic, aligned, extended, inset
}

public enum AxisMark3DPosition {
    case automatic, bottom, leading, top, trailing
}

public enum AxisMark3DValues {
//    case desiredCount(desiredCount: Int? = nil, roundLowerBound: Bool? = nil, roundUpperBound: Bool? = nil),
//         desiredMinium<P>(minimumStride: P, desiredCount: Int? = nil, roundLowerBound: Bool? = nil, roundUpperBound: Bool? = nil),
//         stride<P>(by stepSize: P, roundLowerBound: Bool? = nil, roundUpperBound: Bool? = nil)
}

public struct AxisValue3D {
    let count: Int
    let index: Int

//    func `as`<P: Plottable>(P.Type) -> P?
}

public protocol AxisMark3D {}

public struct AxisTick3D: AxisMark3D {
    let centered: Bool?
    let length: Length
    // let strokeStyle: StrokeStyle?

    init(centered: Bool?, length: Length) {
        self.centered = centered
        self.length = length
    }

    enum Length {
        case automatic,
             length(Double),
             label(extendBy: Double = 0),
             longestLabel(extendBy: Double = 0)
    }
}

public struct AxisGridLine3D: AxisMark3D {
    let centered: Bool?
    // let strokeStyle: StrokeStyle?

    init(centered: Bool? = nil) {
        self.centered = centered
    }
}
