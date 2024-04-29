import RealityKit
import RealityUI
import XCTest

final class RendererUpdateTests: XCTestCase {
    typealias Renderer = RealityUIRenderer

    var renderer: Renderer!
    var root: Entity { renderer.realityRoot }
    var contentRoot: Entity? { renderer.realityRoot.children.first }

    override func setUp() {
        renderer = Renderer()
    }

    let proposeOne = ProposedSize3D(.one)

    func testEmpty() throws {
        let empty = EmptyView3D()

        renderer.update(with: empty, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.View3D?.type, EmptyView3D.contentType)
    }

    func testBox() throws {
        let box = Box3D()

        renderer.update(with: box, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.View3D?.type, Shape3DView<Box3D>.contentType)
    }

    func testFramedBox() throws {
        let framed = Box3D().frame(width: 2.0, height: 3.0, depth: 4.0)

        renderer.update(with: framed, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.View3D?.type, _FrameView3D<Box3D>.contentType)
        XCTAssertEqual(contentRoot?.children.count, 1)
        XCTAssertEqual(contentRoot?.children.first?.View3D?.type, Shape3DView<Box3D>.contentType)
    }

    func testFramedSphere() throws {
        let framed = Sphere3D().frame(width: 2.0, height: 3.0, depth: 4.0)

        renderer.update(with: framed, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.View3D?.type, _FrameView3D<Sphere3D>.contentType)
        XCTAssertEqual(contentRoot?.children.count, 1)
        XCTAssertEqual(contentRoot?.children.first?.View3D?.type, Shape3DView<Sphere3D>.contentType)
    }

    func testFramedSphereAligned() throws {
        let framed = Sphere3D()
            .frame(width: 2.0, height: 3.0, depth: 4.0, alignment: .bottomLeadingFront)

        renderer.update(with: framed, size: .one)

        XCTAssertEqual(root.children.count, 1)
        XCTAssertEqual(contentRoot?.View3D?.type, _FrameView3D<Sphere3D>.contentType)
        XCTAssertEqual(contentRoot?.children.count, 1)
        XCTAssertEqual(contentRoot?.children.first?.View3D?.type, Shape3DView<Sphere3D>.contentType)
    }

    // MARK: - re-render

    func testReUpdateEmpty() throws {
        let content = EmptyView3D()

        renderer.update(with: content, size: .one)
        let content1 = contentRoot
        renderer.update(with: content, size: .one)
        let content2 = contentRoot

        XCTAssertEqual(content1, content2)
    }

    func testReUpdateBox() throws {
        let content = Box3D()

        renderer.update(with: content, size: .one)
        let content1 = contentRoot
        renderer.update(with: content, size: .one)
        let content2 = contentRoot

        XCTAssertEqual(content1, content2)
    }

    func testUpdateBoxToSphere() throws {
        let box = Box3D()
        let sphere = Sphere3D()

        renderer.update(with: box, size: .one)
        let content1 = contentRoot
        renderer.update(with: sphere, size: .one)
        let content2 = contentRoot

        XCTAssertNotEqual(content1, content2)
    }

    func testUpdateFramedBoxWidth() throws {
        let framed = Box3D().frame(width: 2.0, height: 3.0, depth: 4.0)
        let reframed = Box3D().frame(width: 2.0, height: 3.0, depth: 4.0)

        renderer.update(with: framed, size: .one)
        let content1 = contentRoot
        renderer.update(with: reframed, size: .one)
        let content2 = contentRoot

        XCTAssertEqual(content1, content2)
    }
}
