//
// Created by John Griffin on 5/2/24
//

import Charts
import Charts3D
import Spatial
import XCTest

final class PlottableNumericTests: XCTestCase {
    let numeric = NumericDimension(1.0)
    let double = Double(1.0)
    let float = Float(1.0)
    let int = Int(1)

    func testDouble() {
        XCTAssertEqual(NumericDimension.from(double), 1.0)
        XCTAssertEqual(Double.from(numeric), 1.0)
    }

    func testFloat() {
        XCTAssertEqual(NumericDimension.from(float), 1.0)
        XCTAssertEqual(Float.from(numeric), 1.0)
    }

    func testInt() {
        XCTAssertEqual(NumericDimension.from(int), 1.0)
        XCTAssertEqual(Int.from(numeric), 1)
    }
}
