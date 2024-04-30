//
// Created by John Griffin on 4/30/24
//

import Foundation

public struct StrokeStyle3D {
    let lineWidth: Double

    let lineCap: LineCap
    let lineJoin: LineJoin
    let miterLimit: Double
    let dash: [Double]
    let dashPhase: Double

    enum LineCap {}
    enum LineJoin {}
}
