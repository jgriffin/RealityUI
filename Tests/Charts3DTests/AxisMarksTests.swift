//
// Created by John Griffin on 5/2/24
//

import Charts3D
import Spatial
import XCTest

final class AxisMarkValuesTests: XCTestCase {
    let oneTwo = DimensionDomainValues(1, 2)
    let threeFour = DimensionDomainValues(3, 4)
    let fiveSix = DimensionDomainValues(5, 6)

    func testEmpty() {
        let domains = PlottableDomains()
        let proxy = Chart3DProxy(plotSize: .one, domains: domains)
        let marks = Axis3DMarkValues.strideBy(stepSize: 0.1)
        let xValues = marks.resolvedIn(proxy.xDimensionProxy)
        XCTAssertTrue(xValues.isEmpty)
    }

    func testDomainNumericRanges() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)
        let proxy = Chart3DProxy(plotSize: .one, domains: domains)
        let marks = Axis3DMarkValues.strideBy(stepSize: 0.1)
        let xValues = marks.resolvedIn(proxy.xDimensionProxy)

        XCTAssertEqual(xValues.count, 11)
        let floats = xValues.map { Float.from($0.value) }
        XCTAssertEqual(floats, [1.0, 1.1, 1.2, 1.3, 1.4, 1.5, 1.6, 1.7, 1.8, 1.9, 2.0])
    }

    func testPosition() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)
        let proxy = Chart3DProxy(plotSize: .one, domains: domains)
        let position = proxy.positionFor((1.5, 3.5, 5.5))
        XCTAssertEqual(position, Point3D(x: 0.5, y: 0.5, z: 0.5))
    }
}
