//
// Created by John Griffin on 5/24/24
//

@testable import RealityUI
import Spatial
import XCTest

final class ScaleGridTests: XCTestCase {
    typealias Renderer = RealityUIRenderer
    var renderer: Renderer!

    override func setUp() {
        renderer = Renderer()
    }

    func testScaledGrid() {
        let view = ScaledGrid3D(
            domain: Rect3D(origin: .zero, size: .one * 4),
            gridScaleFor: .uniformFit(padding: .one * 0.01)
        ) {
//                Canvas3D {
            Box3D()
                .frame(size: .one)
                .offset(.init(x: 1, y: 1, z: 1))
                //
                //                Box3D()
                //                    .frame(size: .one)
                //                    .offset(.init(x: 9, y: 9, z: 9))
//                }
                .foreground(.cyan20)
        } overlay: { gridScale in
            GridDots3D(gridScale: gridScale)
        }

        let result = Renderer.renderTreeFor(view, size: .one)
        XCTAssertEqual(result.description, "")
    }
}
