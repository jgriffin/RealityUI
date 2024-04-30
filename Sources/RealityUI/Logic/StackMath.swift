//
// Created by John Griffin on 4/19/24
//

import Spatial

/// The match for laying out stacks gets a little subtle, plus we want to do it x three axes, so a little helper
enum StackMath {
    typealias Vector = SIMD3<Double>

    static func mixVectors(
        axis: Vector3D,
        onAxis: Vector3D,
        offAxis: Vector3D
    ) -> Vector3D {
        let axis = axis.vector
        return Vector3D(axis * onAxis.vector + (.one - abs(axis)) * offAxis.vector)
    }

    static func initialChildProposalFrom(
        _ proposal: Size3D,
        axis: Vector3D,
        contentCount: Int,
        spacing _: Size3D
    ) -> Size3D {
        guard contentCount > 0 else { return .zero }
        let divided = mixVectors(
            axis: .init(abs(axis.vector)),
            onAxis: Vector3D(proposal / .init(contentCount)),
            offAxis: Vector3D(proposal)
        )
        return Size3D(divided)
    }

    static func dimsSumAndMax(_ sizes: [Size3D]) -> (sum: Vector3D, max: Vector3D) {
        (
            Vector3D(sizes.map(\.vector).reduce(.zero, +)),
            Vector3D(sizes.map(\.vector).reduce(.zero, pointwiseMax))
        )
    }

    static func sizeFromFits(
        _ sizes: [Size3D],
        spacing: Size3D,
        axis: Vector3D
    ) -> Size3D {
        let dims = dimsSumAndMax(sizes)
        let spacing = spacing * Double(sizes.count - 1)
        let size = mixVectors(
            axis: .init(abs(axis.vector)),
            onAxis: dims.sum + .init(spacing),
            offAxis: dims.max
        )
        return Size3D(size)
    }

    static func stackedOffsets(
        fitSizes: [Size3D],
        spacing: Size3D
    ) -> (centers: [Vector3D], total: Vector3D) {
        let spacing = Vector3D(spacing)

        var current: Vector3D = .zero
        let centers = fitSizes.map { size in
            if current != .zero {
                current += spacing
            }
            defer { current += .init(size) }
            return Vector3D(current + size / 2)
        }

        return (centers, current)
    }

    static func centerOffsets(
        fitSizes: [Size3D],
        spacing: Size3D
    ) -> [Vector3D] {
        let stacked = stackedOffsets(fitSizes: fitSizes, spacing: spacing)

        let totalCenter = stacked.total / 2
        return stacked.centers.map { $0 - totalCenter }
    }
}
