//
// Created by John Griffin on 4/22/24
//

import Charts3D
import XCTest

final class PlottableDomainsTests: XCTestCase {
    func testPointMark() {
        let point = Point3DMark(("x", "y", "z"), (1, 2, 3))

        let result = point.plottableDomains()

        XCTAssertEqual(result.xDomain(Int.self), [1])
        XCTAssertEqual(result.yDomain(Int.self), [2])
        XCTAssertEqual(result.zDomain(Int.self), [3])
    }

    func testPointsMark() {
        let chart = Chart3D {
            Point3DMark(("x", "y", "z"), (1, 2, 3))
            Point3DMark(("x", "y", "z"), (4, 5, 6))
        }

        let result = chart.plottableDomains()

        XCTAssertEqual(result.xDomain(Int.self), [1, 4])
        XCTAssertEqual(result.yDomain(Int.self), [2, 5])
        XCTAssertEqual(result.zDomain(Int.self), [3, 6])
    }

    func testLineMark() {
        let point = Line3DMark(("x", "y", "z"), (1, 2, 3))

        let result = point.plottableDomains()

        XCTAssertEqual(result.xDomain(Int.self), [1])
        XCTAssertEqual(result.yDomain(Int.self), [2])
        XCTAssertEqual(result.zDomain(Int.self), [3])
    }
}
