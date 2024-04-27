//
// Created by John Griffin on 4/18/24
//

import RealityUI
import XCTest

final class RealityBuilderTests: XCTestCase {
    typealias Builder = RealityContentsBuilder

    func testEmpty() {
        let result = Builder.build {}
        XCTAssertEqual(result.count, 0)
    }

    func testBox() {
        let result = Builder.build { Box() }
        XCTAssertEqual(result.count, 1)
        XCTAssertTrue(type(of: result.first!) == Box.self)
    }

    func testMultiple() {
        let result = Builder.build {
            Box()
            Box()
                .frame(size: .one)
            Sphere()
        }
        XCTAssertEqual(result.count, 3)
    }

    func testIf() {
        let no = false
        let result = Builder.build {
            Box()
            if no {
                Box()
            }
            if no {
                Box()
                Sphere()
            }
        }
        XCTAssertEqual(result.count, 1)
    }
}
