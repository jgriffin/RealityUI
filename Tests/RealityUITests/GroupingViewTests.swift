//
// Created by John Griffin on 4/29/24
//

@testable import RealityUI
import XCTest

final class GroupingViewTests: XCTestCase {
    func testEmpty() {
        let content = EmptyView3D()

        let results = groupFlattened(content)

        XCTAssertEqual(results.count, 1)
    }

    func testTuple() {
        let content = TupleView3D(EmptyView3D(), EmptyView3D())

        let results = groupFlattened(content)

        XCTAssertEqual(results.count, 2)
    }

    func testForEach() {
        let content = ForEach3D([0, 1, 2], id: \.self) { _ in
            EmptyView3D()
        }

        let results = groupFlattened(content)

        XCTAssertEqual(results.count, 3)
    }

    func testNested() {
        let content = TupleView3D(
            EmptyView3D(),
            ForEach3D([0, 1, 2], id: \.self) { _ in EmptyView3D() }
        )

        let results = groupFlattened(content)

        XCTAssertEqual(results.count, 4)
    }

    func testLayoutView() {
        let content = LayoutView3D(.alignment()) {
            EmptyView3D()
            ForEach3D([0, 1, 2], id: \.self) { _ in EmptyView3D() }
        }

        let results = groupFlattened(content.content)

        XCTAssertEqual(results.count, 4)
    }
}
