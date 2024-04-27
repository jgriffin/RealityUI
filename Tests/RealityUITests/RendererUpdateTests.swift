import RealityKit
import RealityUI
import XCTest

final class RendererUpdateTests: XCTestCase {
    typealias Renderer = RealityContentRenderer

    var renderer: Renderer!
    var root: Entity { renderer.realityRoot }
    var contentRoot: Entity? { renderer.realityRoot.children.first }

    override func setUp() {
        renderer = Renderer()
    }

    let proposeOne = ProposedSize3D(.one)

    func testEmpty() throws {
        let empty = EmptyContent()

        renderer.update(with: empty, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.realityContent?.type, EmptyContent.contentType)
    }

    func testBox() throws {
        let box = Box()

        renderer.update(with: box, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.realityContent?.type, RealityShapeView<Box>.contentType)
    }

    func testFramedBox() throws {
        let framed = Box().frame(width: 2.0, height: 3.0, depth: 4.0)

        renderer.update(with: framed, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.realityContent?.type, RealityFrame<Box>.contentType)
        XCTAssertEqual(contentRoot?.children.count, 1)
        XCTAssertEqual(contentRoot?.children.first?.realityContent?.type, RealityShapeView<Box>.contentType)
    }

    func testFramedSphere() throws {
        let framed = Sphere().frame(width: 2.0, height: 3.0, depth: 4.0)

        renderer.update(with: framed, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.realityContent?.type, RealityFrame<Sphere>.contentType)
        XCTAssertEqual(contentRoot?.children.count, 1)
        XCTAssertEqual(contentRoot?.children.first?.realityContent?.type, RealityShapeView<Sphere>.contentType)
    }

    func testFramedSphereAligned() throws {
        let framed = Sphere()
            .frame(width: 2.0, height: 3.0, depth: 4.0, alignment: .bottomLeadingFront)

        renderer.update(with: framed, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.realityContent?.type, RealityFrame<Sphere>.contentType)
        XCTAssertEqual(contentRoot?.children.count, 1)
        XCTAssertEqual(contentRoot?.children.first?.realityContent?.type, RealityShapeView<Sphere>.contentType)
    }

    // MARK: - re-render

    func testReUpdateEmpty() throws {
        let content = EmptyContent()

        renderer.update(with: content, size: .one)
        let content1 = contentRoot
        renderer.update(with: content, size: .one)
        let content2 = contentRoot

        XCTAssertEqual(content1, content2)
    }

    func testReUpdateBox() throws {
        let content = Box()

        renderer.update(with: content, size: .one)
        let content1 = contentRoot
        renderer.update(with: content, size: .one)
        let content2 = contentRoot

        XCTAssertEqual(content1, content2)
    }

    func testUpdateBoxToSphere() throws {
        let box = Box()
        let sphere = Sphere()

        renderer.update(with: box, size: .one)
        let content1 = contentRoot
        renderer.update(with: sphere, size: .one)
        let content2 = contentRoot

        XCTAssertNotEqual(content1, content2)
    }

    func testUpdateFramedBoxWidth() throws {
        let framed = Box().frame(width: 2.0, height: 3.0, depth: 4.0)
        let reframed = Box().frame(width: 2.0, height: 3.0, depth: 4.0)

        renderer.update(with: framed, size: .one)
        let content1 = contentRoot
        renderer.update(with: reframed, size: .one)
        let content2 = contentRoot

        XCTAssertEqual(content1, content2)
    }
}
