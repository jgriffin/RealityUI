//
// Created by John Griffin on 4/22/24
//

@testable import Charts3D
import RealityUI
import XCTest

final class ChartRenderTests: XCTestCase {
    let nullProxy = Chart3DProxy(plotSize: .one, domains: .init())

    func testEmpty() {
        let chart = Chart3D {}
        let result = chart.renderView(nullProxy, .init())
        print(result)
    }

    func testPoint() {
        let chart = Chart3D {
            Point3DMark(("x", "y", "z"), (0, 0, 0))
        }
        let result = chart.renderView(nullProxy, .init())

        print(result)
    }
}
