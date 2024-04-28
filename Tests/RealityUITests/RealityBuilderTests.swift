//
// Created by John Griffin on 4/18/24
//

@testable import RealityUI
import XCTest

final class RealityBuilderTests: XCTestCase {
    typealias Builder = RealityContentBuilder

    func testEmpty() {
        let result = Builder.build {}
        XCTAssertTrue(type(of: result) == EmptyContent.self)
    }

    func testBox() {
        let result = Builder.build { Box() }
        XCTAssertTrue(type(of: result) == Box.self)
    }

    func testMultiple() {
        let result = Builder.build {
            Box()
            Box()
                .frame(size: .one)
            Sphere()
        }
        XCTAssertEqual(result.contentsCount, 3)
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
        XCTAssertEqual(result.contentsCount, 3)
    }
}
