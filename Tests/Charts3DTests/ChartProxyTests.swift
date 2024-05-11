//
// Created by John Griffin on 5/2/24
//

import Charts3D
import Spatial
import XCTest

final class ChartProxyTests: XCTestCase {
    let oneTwo = PlottableDomainValues(1, 2)
    let threeFour = PlottableDomainValues(3, 4)
    let fiveSix = PlottableDomainValues(5, 6)

    func testEmpty() {
        let domains = PlottableDomains()

        let proxy = Chart3DProxy(chartSize: .one, domains: domains)

        XCTAssertEqual(proxy.dimension.x.domainNumericRange, 0 ... 1)
        XCTAssertEqual(proxy.dimension.y.domainNumericRange, 0 ... 1)
        XCTAssertEqual(proxy.dimension.z.domainNumericRange, 0 ... 1)
    }

    func testDomainNumericRanges() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)

        let proxy = Chart3DProxy(
            chartSize: .one, domains: domains,
            domainScale: .automatic(includesZero: false)
        )

        XCTAssertEqual(proxy.dimension.x.domainNumericRange, 1 ... 2)
        XCTAssertEqual(proxy.dimension.y.domainNumericRange, 3 ... 4)
        XCTAssertEqual(proxy.dimension.z.domainNumericRange, 5 ... 6)
    }

    func testDomainNumericRangesIncludeZero() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)

        let proxy = Chart3DProxy(
            chartSize: .one, domains: domains,
            domainScale: .automatic(includesZero: true)
        )

        XCTAssertEqual(proxy.dimension.x.domainNumericRange, 0 ... 2)
        XCTAssertEqual(proxy.dimension.y.domainNumericRange, 0 ... 4)
        XCTAssertEqual(proxy.dimension.z.domainNumericRange, 0 ... 6)
    }

    func testPosition() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)

        let proxy = Chart3DProxy(
            chartSize: .one, domains: domains,
            domainScale: .automatic(includesZero: false)
        )

        let position = proxy.positionFor((1.5, 3.5, 5.5))
        XCTAssertEqual(position, Point3D(x: 0.5, y: 0.5, z: 0.5))
    }
}
