//
// Created by John Griffin on 4/19/24
//

@testable import RealityUI
import Spatial
import XCTest

final class StackMathTests: XCTestCase {
    // MARK: - .greatestFiniteMagnitude and .infinity

    let dInf: Double = .infinity
    let dMax: Double = .greatestFiniteMagnitude
    let sd3Inf: SIMD3<Double> = [.infinity, .infinity, .infinity]
    let sd3Max: SIMD3<Double> = [.greatestFiniteMagnitude, .greatestFiniteMagnitude, .greatestFiniteMagnitude]
    let sd123: SIMD3<Double> = [1, 2, 3]

    func testGFMAndInfinity() {
        XCTAssertNotEqual(dMax, dInf)
        XCTAssertTrue(dMax < dInf)
        XCTAssertEqual(min(dMax, dInf), dMax)
    }

    func testGFMOverflowsToInf() {
        let result = Double.greatestFiniteMagnitude + Double.greatestFiniteMagnitude
        XCTAssertEqual(result, .infinity)
    }

    func testSIMD3Overflow() {
        let result = sd3Max + sd3Max
        XCTAssertEqual(result, sd3Inf)
    }

    func testSIMD3Min() {
        XCTAssertEqual(min(sd3Max, sd3Inf), sd3Max)
        XCTAssertEqual(min(sd3Max, [1, .infinity, 2]), [1, .greatestFiniteMagnitude, 2])
    }

    func testNegativeVectorComponents() {
        let vector = Vector3D([1.0, -2, 3])
        let size = Size3D(vector)
        XCTAssertEqual(size.vector, vector.vector)
        XCTAssertEqual(abs(vector.vector), [1.0, 2, 3])
    }

    // MARK: - Stack Math

    func testDimsSumAndMax() {
        let fitSizes = [Size3D(sd123), Size3D(sd123)]
        let dims = StackMath.dimsSumAndMax(fitSizes)

        XCTAssertEqual(dims.max.vector, sd123)
        XCTAssertEqual(dims.sum.vector, [2, 4, 6])
    }

    func testSizeFromFits() {
        let fitSizes = [Size3D(sd123), Size3D(sd123)]

        let hSize = StackMath.sizeFromFits(fitSizes, spacing: .zero, axis: .right)
        XCTAssertEqual(hSize, Size3D([2.0, 2, 3]))

        let ySize = StackMath.sizeFromFits(fitSizes, spacing: .zero, axis: .up)
        XCTAssertEqual(ySize, Size3D([1.0, 4, 3]))

        let zSize = StackMath.sizeFromFits(fitSizes, spacing: .zero, axis: .forward)
        XCTAssertEqual(zSize, Size3D([1.0, 2, 6]))
    }

    func testStackedOffsets() {
        let fitSizes = [Size3D(sd123), Size3D(sd123)]
        let hPoints = StackMath.stackedOffsets(fitSizes: fitSizes, spacing: .zero)
        XCTAssertEqual(hPoints.centers.map(\.vector), [[0.5, 1.0, 1.5], [1.5, 3.0, 4.5]])
    }

    func testCenterOffsetsFromStackCenter() {
        let fitSizes = [Size3D(sd123), Size3D(sd123)]
        let centerOffsets = StackMath.centerOffsets(fitSizes: fitSizes, spacing: .zero)

        XCTAssertEqual(centerOffsets.map(\.vector), [[-0.5, -1, -1.5], [0.5, 1, 1.5]])
    }
}
