@testable import RealityUI
import XCTest

final class RendererRenderTreeTests: XCTestCase {
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
    }

    func testBox() throws {
        let box = Box3D()

        let result = Renderer.renderTreeFor(box, size: .one)

        XCTAssertEqual(result.View3D?.type, Shape3DView<Box3D>.contentType)
        XCTAssertTrue(result.children.isEmpty)
    }

    func testFramedBox() throws {
        let framed = Box3D()
            .frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.View3D?.type, _FrameView3D<Box3D>.contentType)
        XCTAssertEqual(result.transform.translation, .zero)
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.View3D?.type, Shape3DView<Box3D>.contentType)
    }

    func testFramedSphere() throws {
        let framed = Sphere3D()
            .frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.View3D?.type, _FrameView3D<Sphere3D>.contentType)
        XCTAssertEqual(result.transform.translation, .zero)
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.View3D?.type, Shape3DView<Sphere3D>.contentType)
    }

    func testFramedSphereAligned() throws {
        let framed = Sphere3D()
            .frame(width: 2.0, height: 3.0, depth: 4.0, alignment: .bottomLeadingFront)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.View3D?.type, _FrameView3D<Sphere3D>.contentType)
        XCTAssertEqual(result.transform.translation, .init(x: 0.0, y: -0.5, z: 1.0))
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.View3D?.type, Shape3DView<Sphere3D>.contentType)
    }
}
