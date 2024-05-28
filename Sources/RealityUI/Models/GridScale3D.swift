//
// Created by John Griffin on 5/22/24
//

import Spatial

/// The information needed for scaling a coordinate space into volume
///
/// For example, say you've got an arbitrarily sized group of 3d blocks that you want to display in a volume,
/// GridScale3D is meant to represent the information needed to render a set of axis in an overlay that matches
/// the rendered content
public struct GridScale3D: CustomStringConvertible {
    // the "natural" units ... that got scaled into the volume
    public let domain: Rect3D
    // an origin + size of output volume domain is mapped into
    public let bounds: Rect3D
    // scale used to fit domain into bounds
    public let scale: Size3D

    public init(
        domain: Rect3D,
        bounds: Rect3D,
        scale: Size3D
    ) {
        self.domain = domain
        self.bounds = bounds
        self.scale = scale
    }

    public var description: String {
        "domain: \(domain)"
    }
}

public extension GridScale3D {
    var domainX: DoubleRange { domain.min.x ... domain.max.x }
    var domainY: DoubleRange { domain.min.y ... domain.max.y }
    var domainZ: DoubleRange { domain.min.z ... domain.max.z }
    var boundsX: DoubleRange { bounds.min.x ... bounds.max.x }
    var boundsY: DoubleRange { bounds.min.y ... bounds.max.y }
    var boundsZ: DoubleRange { bounds.min.z ... bounds.max.z }

    func boundsPointFrom(domain: Point3D) -> Point3D {
        Point3D(x: boundsXFrom(domainX: domain.x),
                y: boundsYFrom(domainY: domain.y),
                z: boundsZFrom(domainZ: domain.z))
    }

    func boundsXFrom(domainX x: Double) -> Double {
        boundsX.lerp(x, in: domainX)
    }

    func boundsYFrom(domainY y: Double) -> Double {
        boundsY.lerp(y, in: domainY)
    }

    func boundsZFrom(domainZ z: Double) -> Double {
        boundsZ.lerp(z, in: domainZ)
    }
}

/// wrapper around logic to scale domain into (proposed) size
public struct GridScaleFor {
    let gridScaleFor: (_ domain: Rect3D, _ size: Size3D) -> GridScale3D

    public init(gridScaleFor: @escaping (_ domain: Rect3D, _ size: Size3D) -> GridScale3D) {
        self.gridScaleFor = gridScaleFor
    }

    public func callAsFunction(domain: Rect3D, size: Size3D) -> GridScale3D {
        gridScaleFor(domain, size)
    }

    /// calculates uniformly sclaed fit with some padding so we can draw stuff at the edges and stay inside the volume
    public static func uniformFit(padding: Size3D = .one * 0.01) -> GridScaleFor {
        GridScaleFor { domain, size in
            let domainAspectRatio = domain.size
            let sizeThatFits = AspectRatioMath.scaledToFit(domainAspectRatio, into: size, maxScale: nil)
            let bounds = Rect3D(center: .zero, size: sizeThatFits).inset(by: padding)
            let scale = AspectRatioMath.scaleToFit(domain.size, into: bounds.size)

            return GridScale3D(
                domain: domain,
                bounds: bounds,
                scale: .one * scale
            )
        }
    }
}
