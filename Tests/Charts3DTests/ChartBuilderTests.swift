//
// Created by John Griffin on 4/22/24
//

import Charts3D
import XCTest

final class ChartBuilderTests: XCTestCase {
    func testEmpty() {
        let chart = Chart3D {}
        XCTAssert(type(of: chart.content) == EmptyChartContent.self)
    }

    func testPoint() {
        let chart = Chart3D {
            PointMark(x: .value("x", 1), y: .value("y", 2), z: .value("z", 3))
        }

        let content = chart.content
        XCTAssertEqual(content.contents.count, 1)
        XCTAssert(content.contents.first.map { type(of: $0) } == PointMark<Int, Int, Int>.self)
    }

    func testPoints() {
        let chart = Chart3D {
            PointMark(x: .value("x", 1), y: .value("y", 2), z: .value("z", 3))
            PointMark(x: .value("x", 4), y: .value("y", 5), z: .value("z", 6))
        }

        let content = chart.content
        XCTAssertEqual(content.contents.count, 2)
        XCTAssert(content.contents.first.map { type(of: $0) } == PointMark<Int, Int, Int>.self)
        XCTAssert(content.contents.last.map { type(of: $0) } == PointMark<Int, Int, Int>.self)
    }
}
