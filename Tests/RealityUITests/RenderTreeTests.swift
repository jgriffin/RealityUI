@testable import RealityUI
import Spatial
import XCTest

final class RenderTreeTests: XCTestCase {
    typealias Renderer = RealityUIRenderer

    var renderer: Renderer!

    override func setUp() {
        renderer = Renderer()
    }

    func testEmptyView() throws {
        let empty = EmptyView3D()

        let result = Renderer.renderTreeFor(empty, size: .one)

        XCTAssertEqual(result.View3D?.type, EmptyView3D.contentType)
        XCTAssertTrue(result.children.isEmpty)
        XCTAssertEqual(result.description, "EmptyView3D")
    }

    func testBox() throws {
        let box = Box3D()

        let result = Renderer.renderTreeFor(box, size: .one)

        XCTAssertEqual(result.View3D?.type, Shape3DView<Box3D>.contentType)
        XCTAssertTrue(result.children.isEmpty)
        XCTAssertEqual(result.description, "Shape3DView<Box3D> (width: 1.0, height: 1.0, depth: 1.0)")
    }

    func testFramedBox() throws {
        let framed = Box3D()
            .frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.View3D?.type, _Frame3D<Box3D>.contentType)
        XCTAssertEqual(result.transform.translation, .zero)
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.View3D?.type, Shape3DView<Box3D>.contentType)
        XCTAssertEqual(result.description, """
        _FrameView3D<Box3D>
            Shape3DView<Box3D> (width: 2.0, height: 3.0, depth: 4.0)
        """)
    }

    func testFramedSphere() throws {
        let framed = Sphere3D()
            .frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.View3D?.type, _Frame3D<Sphere3D>.contentType)
        XCTAssertEqual(result.transform.translation, .zero)
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.View3D?.type, Shape3DView<Sphere3D>.contentType)
        XCTAssertEqual(result.description, """
        _FrameView3D<Sphere3D>
            Shape3DView<Sphere3D> (width: 2.0, height: 3.0, depth: 4.0)
        """)
    }

    func testFramedSphereAligned() throws {
        let framed = Sphere3D()
            .frame(width: 2.0, height: 3.0, depth: 4.0, alignment: .bottomLeadingFront)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.View3D?.type, _Frame3D<Sphere3D>.contentType)
        XCTAssertEqual(result.transform.translation, .init(x: 0.0, y: -0.5, z: 1.0))
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.View3D?.type, Shape3DView<Sphere3D>.contentType)
        XCTAssertEqual(result.description, """
        _FrameView3D<Sphere3D> translation: SIMD3<Float>(0.0, -0.5, 1.0)
            Shape3DView<Sphere3D> (width: 2.0, height: 3.0, depth: 4.0)
        """)
    }

    func testLine() {
        let points = [
            Vector3D.bottomLeading, .bottomTrailing, .topTrailing, .topLeading,
        ].map { Point3D($0 * 0.2) }

        let line = Line3D(points)

        let result = Renderer.renderTreeFor(line, size: .one)
        XCTAssertEqual(result.description, """
        Line3D [(x: 0.0, y: 0.0, z: 0.1), (x: 0.2, y: 0.0, z: 0.1), (x: 0.2, y: 0.2, z: 0.1), (x: 0.0, y: 0.2, z: 0.1)]
            _IDView3D<_LineSegment3D, Int> 0
                _LineSegment3D ((x: 0.0, y: 0.0, z: 0.1), (x: 0.2, y: 0.0, z: 0.1)) translation: SIMD3<Float>(0.1, 0.0, 0.1) rotatation angle: 1.5707964 axis: SIMD3<Float>(0.0, 0.0, -0.99999994)
            _IDView3D<_LineSegment3D, Int> 1
                _LineSegment3D ((x: 0.2, y: 0.0, z: 0.1), (x: 0.2, y: 0.2, z: 0.1)) translation: SIMD3<Float>(0.2, 0.1, 0.1)
            _IDView3D<_LineSegment3D, Int> 2
                _LineSegment3D ((x: 0.2, y: 0.2, z: 0.1), (x: 0.0, y: 0.2, z: 0.1)) translation: SIMD3<Float>(0.1, 0.2, 0.1) rotatation angle: 1.5707964 axis: SIMD3<Float>(0.0, 0.0, 0.99999994)
        """)
    }
}
