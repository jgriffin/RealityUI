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
        let view = DomainView3D(
            domain: Rect3D(center: .zero, size: .one * 2),
            gridScaleFor: .uniformFit(padding: .zero)
        ) {
            Box3D()
                .frame(size: .one * 1)
        } overlay: { gridScale in
            GridDots3D(gridScale: gridScale)
        }

        let result = Renderer.renderTreeFor(view, size: .one)
        XCTAssertEqual(result.description, """
        ScaledGrid3D domain: (origin: (x: -1.0, y: -1.0, z: -1.0), size: (width: 2.0, height: 2.0, depth: 2.0))
            _Scale3D (width: 0.5, height: 0.5, depth: 0.5) scale: SIMD3<Float>(0.5, 0.5, 0.5)
                _Frame3D (width: 1.0, height: 1.0, depth: 1.0)
                    Shape3DView Box3D
            Stack3D AlignmentLayout3D center
                Stack3D AlignmentLayout3D center
                    _ID3D (x: -0.5, y: -0.5, z: -0.5)
                        _Offset3D (x: -0.5, y: -0.5, z: -0.5) translation: SIMD3<Float>(-0.5, -0.5, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: -0.5, y: -0.5, z: 0.0)
                        _Offset3D (x: -0.5, y: -0.5, z: 0.0) translation: SIMD3<Float>(-0.5, -0.5, 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: -0.5, y: -0.5, z: 0.5)
                        _Offset3D (x: -0.5, y: -0.5, z: 0.5) translation: SIMD3<Float>(-0.5, -0.5, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: -0.5, y: 0.0, z: -0.5)
                        _Offset3D (x: -0.5, y: 0.0, z: -0.5) translation: SIMD3<Float>(-0.5, 0.0, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: -0.5, y: 0.0, z: 0.0)
                        _Offset3D (x: -0.5, y: 0.0, z: 0.0) translation: SIMD3<Float>(-0.5, 0.0, 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: -0.5, y: 0.0, z: 0.5)
                        _Offset3D (x: -0.5, y: 0.0, z: 0.5) translation: SIMD3<Float>(-0.5, 0.0, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: -0.5, y: 0.5, z: -0.5)
                        _Offset3D (x: -0.5, y: 0.5, z: -0.5) translation: SIMD3<Float>(-0.5, 0.5, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: -0.5, y: 0.5, z: 0.0)
                        _Offset3D (x: -0.5, y: 0.5, z: 0.0) translation: SIMD3<Float>(-0.5, 0.5, 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: -0.5, y: 0.5, z: 0.5)
                        _Offset3D (x: -0.5, y: 0.5, z: 0.5) translation: SIMD3<Float>(-0.5, 0.5, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: -0.5, z: -0.5)
                        _Offset3D (x: 0.0, y: -0.5, z: -0.5) translation: SIMD3<Float>(0.0, -0.5, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: -0.5, z: 0.0)
                        _Offset3D (x: 0.0, y: -0.5, z: 0.0) translation: SIMD3<Float>(0.0, -0.5, 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: -0.5, z: 0.5)
                        _Offset3D (x: 0.0, y: -0.5, z: 0.5) translation: SIMD3<Float>(0.0, -0.5, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: 0.0, z: -0.5)
                        _Offset3D (x: 0.0, y: 0.0, z: -0.5) translation: SIMD3<Float>(0.0, 0.0, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: 0.0, z: 0.0)
                        _Offset3D (x: 0.0, y: 0.0, z: 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: 0.0, z: 0.5)
                        _Offset3D (x: 0.0, y: 0.0, z: 0.5) translation: SIMD3<Float>(0.0, 0.0, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: 0.5, z: -0.5)
                        _Offset3D (x: 0.0, y: 0.5, z: -0.5) translation: SIMD3<Float>(0.0, 0.5, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: 0.5, z: 0.0)
                        _Offset3D (x: 0.0, y: 0.5, z: 0.0) translation: SIMD3<Float>(0.0, 0.5, 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.0, y: 0.5, z: 0.5)
                        _Offset3D (x: 0.0, y: 0.5, z: 0.5) translation: SIMD3<Float>(0.0, 0.5, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: -0.5, z: -0.5)
                        _Offset3D (x: 0.5, y: -0.5, z: -0.5) translation: SIMD3<Float>(0.5, -0.5, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: -0.5, z: 0.0)
                        _Offset3D (x: 0.5, y: -0.5, z: 0.0) translation: SIMD3<Float>(0.5, -0.5, 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: -0.5, z: 0.5)
                        _Offset3D (x: 0.5, y: -0.5, z: 0.5) translation: SIMD3<Float>(0.5, -0.5, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: 0.0, z: -0.5)
                        _Offset3D (x: 0.5, y: 0.0, z: -0.5) translation: SIMD3<Float>(0.5, 0.0, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: 0.0, z: 0.0)
                        _Offset3D (x: 0.5, y: 0.0, z: 0.0) translation: SIMD3<Float>(0.5, 0.0, 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: 0.0, z: 0.5)
                        _Offset3D (x: 0.5, y: 0.0, z: 0.5) translation: SIMD3<Float>(0.5, 0.0, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: 0.5, z: -0.5)
                        _Offset3D (x: 0.5, y: 0.5, z: -0.5) translation: SIMD3<Float>(0.5, 0.5, -0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: 0.5, z: 0.0)
                        _Offset3D (x: 0.5, y: 0.5, z: 0.0) translation: SIMD3<Float>(0.5, 0.5, 0.0)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
                    _ID3D (x: 0.5, y: 0.5, z: 0.5)
                        _Offset3D (x: 0.5, y: 0.5, z: 0.5) translation: SIMD3<Float>(0.5, 0.5, 0.5)
                            _Frame3D (width: 0.01, height: 0.01, depth: 0.01)
                                Shape3DView Sphere3D
        """)
    }
}
