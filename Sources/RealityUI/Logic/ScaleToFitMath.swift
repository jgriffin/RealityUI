//
// Created by John Griffin on 4/21/24
//

import Spatial

enum AspectRatioMath {
    // MARK: - fit

    static func scaleToFit(_ size: Size3D, into: Size3D) -> Double {
        let ratios = into.vector / size.vector
        return ratios.min()
    }

    static func scaledToFit(_ size: Size3D, into: Size3D, maxScale: Double?) -> Size3D {
        size * min(scaleToFit(size, into: into), maxScale ?? .greatestFiniteMagnitude)
    }

    static func scaledToFit(_ size: Size3D, aspectRatio: Size3D, maxScale: Double?) -> Size3D {
        scaledToFit(
            scaledToFit(aspectRatio, into: size, maxScale: nil),
            into: size,
            maxScale: maxScale
        )
    }

    // MARK: - fill

    static func scaleToFill(_ size: Size3D, into: Size3D) -> Double {
        let ratios = into.vector / size.vector
        return ratios.max()
    }

    static func scaledToFill(_ size: Size3D, into: Size3D, maxScale: Double?) -> Size3D {
        size * min(scaleToFill(size, into: into), maxScale ?? .greatestFiniteMagnitude)
    }

    static func scaledToFill(_ size: Size3D, aspectRatio: Size3D, maxScale: Double?) -> Size3D {
        scaledToFill(
            scaledToFill(aspectRatio, into: size, maxScale: nil),
            into: size,
            maxScale: maxScale
        )
    }
}
