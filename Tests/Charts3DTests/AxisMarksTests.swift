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
        let markValues = Axis3DMarkValues.strideBy(stepSize: 0.2)

        let xValues = markValues.resolvedIn(proxy.xDimensionProxy)
        let yValues = markValues.resolvedIn(proxy.yDimensionProxy)
        let zValues = markValues.resolvedIn(proxy.zDimensionProxy)

        let xFloats = xValues.compactMap { Float.from($0.value) }
        let yFloats = yValues.compactMap { Float.from($0.value) }
        let zFloats = zValues.compactMap { Float.from($0.value) }
        XCTAssertEqual(xFloats, [1.0, 1.2, 1.4, 1.6, 1.8, 2.0])
        XCTAssertEqual(yFloats, [3.0, 3.2, 3.4, 3.6, 3.8, 4.0])
        XCTAssertEqual(zFloats, [5.0, 5.2, 5.4, 5.6, 5.8, 6.0])
    }

    func testXAxisMarks() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)
        let proxy = Chart3DProxy(plotSize: .one, domains: domains)
        let dimensionProxy = proxy.xDimensionProxy

        let axisMarks = Axis3DMarks(values: .strideBy(stepSize: 0.2)) { _ in
            Axis3DGridLine()
        }

        let view = axisMarks.renderView(dimensionProxy, .init())
        let render = view.renderWithSize(.one, .init())
        print(render)
    }

    func testYAxisMarks() {
        let domains = PlottableDomains(x: oneTwo, y: threeFour, z: fiveSix)
        let proxy = Chart3DProxy(plotSize: .one, domains: domains)
        let dimensionProxy = proxy.yDimensionProxy

        let axisMarks = Axis3DMarks(values: .strideBy(stepSize: 0.2)) { _ in
            Axis3DGridLine()
        }

        let view = axisMarks.renderView(dimensionProxy, .init())
        let render = view.renderWithSize(.one, .init())
        print(render)
    }
}
