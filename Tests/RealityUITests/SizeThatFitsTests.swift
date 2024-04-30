import RealityUI
import XCTest

final class SizeThatFitsTests: XCTestCase {
    let proposeOne = ProposedSize3D(.one)

    func testEmpty() {
        let empty = EmptyView3D()
        let result = empty.sizeThatFits(proposeOne, .init())
        XCTAssertEqual(result, .zero)
    }

    func testBox() {
        let box = Box3D()
        let result = box.sizeThatFits(proposeOne, .init())
        XCTAssertEqual(result, .one)
    }

    func testFramedBox() {
        let framed = Box3D().frame(width: 2.0, height: 3.0, depth: 4.0)
        let result = framed.sizeThatFits(proposeOne, .init())
        XCTAssertEqual(result, .init(width: 2.0, height: 3.0, depth: 4.0))
    }

    func testFramedSphere() {
        let framed = Sphere3D().frame(width: 2.0, height: 3.0, depth: 4.0)
        let result = framed.sizeThatFits(proposeOne, .init())
        XCTAssertEqual(result, .init(width: 2.0, height: 3.0, depth: 4.0))
    }
}
