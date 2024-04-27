//
// Created by John Griffin on 4/21/24
//

import Spatial

enum AspectRatioMath {
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
}
