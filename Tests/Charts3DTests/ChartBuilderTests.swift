//
// Created by John Griffin on 4/22/24
//

@testable import Charts3D
import XCTest

final class ChartBuilderTests: XCTestCase {
    func testEmpty() {
        let chart = Chart3D {}
        XCTAssert(type(of: chart.content) == EmptyChart3DContent.self)
    }

    func testPoint() {
        let chart = Chart3D {
            Point3DMark(x: .value("x", 1), y: .value("y", 2), z: .value("z", 3))
        }

        let content = chart.content
        XCTAssert(type(of: content) == Point3DMark<Int, Int, Int>.self)
    }

    func testPoints() {
        let chart = Chart3D {
            Point3DMark(x: .value("x", 1), y: .value("y", 2), z: .value("z", 3))
            Point3DMark(x: .value("x", 4), y: .value("y", 5), z: .value("z", 6))
        }

        let content = chart.content
        XCTAssertEqual(content.contentsCount, 2)
        XCTAssert(content.contents.first.map { type(of: $0) } == Point3DMark<Int, Int, Int>.self)
        XCTAssert(content.contents.last.map { type(of: $0) } == Point3DMark<Int, Int, Int>.self)
    }
}
