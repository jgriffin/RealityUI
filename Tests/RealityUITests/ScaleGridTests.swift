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
            domain: Rect3D(center: .zero, size: .one * 2),
            gridScaleFor: .uniformFit(padding: .zero)
        ) {
//                Canvas3D {
            Box3D()
                .frame(size: .one * 1)
//                .offset(.init(x: 1, y: 1, z: 1))
                //
                //                Box3D()
                //                    .frame(size: .one)
                //                    .offset(.init(x: 9, y: 9, z: 9))
//                }
                .foreground(.cyan20)
        } overlay: { _ in
//            GridDots3D(gridScale: gridScale)
        }

        let result = Renderer.renderTreeFor(view, size: .one)
        XCTAssertEqual(result.description, """
        ScaledGrid3D domain: (origin: (x: -1.0, y: -1.0, z: -1.0), size: (width: 2.0, height: 2.0, depth: 2.0))
            _Scale3D scale: SIMD3<Float>(0.5, 0.5, 0.5)
                _Frame3D (width: 1.0, height: 1.0, depth: 1.0)
                    Shape3DView (width: 1.0, height: 1.0, depth: 1.0)
            EmptyView3D
        """)
    }
}
