//
// Created by John Griffin on 5/26/24
//

@testable import RealityUI
import Spatial
import XCTest

final class StackTests: XCTestCase {
    typealias Renderer = RealityUIRenderer
    var renderer: Renderer!

    override func setUp() {
        renderer = Renderer()
    }

    func testStackSphereTest() {
        let view = Stack3D {
            Sphere3D()
                .frame(size: 0.2)
        }

        let result = Renderer.renderTreeFor(view, size: .one)
        XCTAssertEqual(result.description, """
        Stack3D AlignmentLayout3D center
            _FixedFrame3D (width: 0.2, height: 0.2, depth: 0.2)
                Shape3DView Sphere3D
        """)
    }
}
