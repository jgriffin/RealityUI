//
// Created by John Griffin on 5/2/24
//

import Charts3D
import Spatial
import XCTest

final class ChartProxyTests: XCTestCase {
    let oneTwo = DimensionDomainValues(1, 2)
    let threeFour = DimensionDomainValues(3, 4)
    let fiveSix = DimensionDomainValues(5, 6)

    func testEmpty() {
        let domains = PlottableDomains()
        let proxy = Chart3DProxy(plotSize: .one, domains: domains)
        XCTAssertNil(proxy.numericDomains.x)
        XCTAssertNil(proxy.numericDomains.y)
        XCTAssertNil(proxy.numericDomains.z)
    }

    func testDomainNumericRanges() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)
        let proxy = Chart3DProxy(plotSize: .one, domains: domains)
        XCTAssertEqual(proxy.numericDomains.x, 1 ... 2)
        XCTAssertEqual(proxy.numericDomains.y, 3 ... 4)
        XCTAssertEqual(proxy.numericDomains.z, 5 ... 6)
    }

    func testPosition() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)
        let proxy = Chart3DProxy(plotSize: .one, domains: domains)
        let position = proxy.positionFor((1.5, 3.5, 5.5))
        XCTAssertEqual(position, Point3D(x: 0.5, y: 0.5, z: 0.5))
    }
}
