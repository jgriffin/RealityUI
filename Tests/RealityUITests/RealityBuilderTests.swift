//
// Created by John Griffin on 4/18/24
//

@testable import RealityUI
import XCTest

final class RealityBuilderTests: XCTestCase {
    typealias Builder = View3DBuilder

    func testEmpty() {
        let result = Builder.build {}
        XCTAssertTrue(type(of: result) == EmptyView3D.self)
    }

    func testBox() {
        let result = Builder.build { Box3D() }
        XCTAssertTrue(type(of: result) == Box3D.self)
    }

    func testMultiple() {
        let result = Builder.build {
            Box3D()
            Box3D()
                .frame(size: .one)
            Sphere3D()
        }
        XCTAssertEqual(result.contentsCount, 3)
    }

    func testIf() {
        let no = false
        let result = Builder.build {
            Box3D()
            if no {
                Box3D()
            }
            if no {
                Box3D()
                Sphere3D()
            }
        }
        XCTAssertEqual(result.contentsCount, 3)
    }
}
