//
// Created by John Griffin on 4/22/24
//

@testable import Charts3D
@testable import RealityUI
import XCTest

final class ChartRenderTests: XCTestCase {
    let nullProxy = Chart3DProxy(chartSize: .one, domains: .init())

    func testEmpty() {
        let chart = Chart3D {}
        let result = chart.renderView(nullProxy, .init())
        print(result.description)
    }

    func testPoint() {
        let chart = Chart3D {
            Point3DMark(("x", "y", "z"), (0, 0, 0))
        }
        let result = chart.renderWithSize(.one, .one, .init())
        print(result.description)
    }

    func testTwoPoints() {
        let chart = Chart3D {
            Point3DMark(("x", "y", "z"), (0, 0, 0))
            Point3DMark(("x", "y", "z"), (2, 2, 2))
        }
        let result = chart.renderWithSize(.one, .one, .init())
        print(result.description)
    }
}
