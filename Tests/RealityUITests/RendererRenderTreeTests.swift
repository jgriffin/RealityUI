@testable import RealityUI
import XCTest

final class RendererRenderTreeTests: XCTestCase {
    typealias Renderer = RealityContentRenderer

    var renderer: Renderer!

    override func setUp() {
        renderer = Renderer()
    }

    func testEmptyView() throws {
        let empty = EmptyContent()

        let result = Renderer.renderTreeFor(empty, size: .one)

        XCTAssertEqual(result.realityContent?.type, EmptyContent.contentType)
        XCTAssertTrue(result.children.isEmpty)
    }

    func testBox() throws {
        let box = Box()

        let result = Renderer.renderTreeFor(box, size: .one)

        XCTAssertEqual(result.realityContent?.type, RealityShapeView<Box>.contentType)
        XCTAssertTrue(result.children.isEmpty)
    }

    func testFramedBox() throws {
        let framed = Box()
            .frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.realityContent?.type, RealityFrame<Box>.contentType)
        XCTAssertEqual(result.transform.translation, .zero)
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.realityContent?.type, RealityShapeView<Box>.contentType)
    }

    func testFramedSphere() throws {
        let framed = Sphere()
            .frame(width: 2.0, height: 3.0, depth: 4.0)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.realityContent?.type, RealityFrame<Sphere>.contentType)
        XCTAssertEqual(result.transform.translation, .zero)
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.realityContent?.type, RealityShapeView<Sphere>.contentType)
    }

    func testFramedSphereAligned() throws {
        let framed = Sphere()
            .frame(width: 2.0, height: 3.0, depth: 4.0, alignment: .bottomLeadingFront)

        let result = Renderer.renderTreeFor(framed, size: .one)

        XCTAssertEqual(result.realityContent?.type, RealityFrame<Sphere>.contentType)
        XCTAssertEqual(result.transform.translation, .init(x: 0.0, y: -0.5, z: 1.0))
        XCTAssertEqual(result.children.count, 1)
        XCTAssertEqual(result.children.first?.realityContent?.type, RealityShapeView<Sphere>.contentType)
    }
}
