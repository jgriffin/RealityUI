//
// Created by John Griffin on 5/22/24
//

import Spatial

/// The information needed for scaling a coordinate space into volume
///
/// For example, say you've got an arbitrarily sized group of 3d blocks that you want to display in a volume,
/// DomainScale3D is meant to represent the information needed to render a set of axis in an overlay that matches
/// the rendered content
public struct DomainScale3D: CustomStringConvertible, Sendable {
    // the "natural" units ... that got scaled into the volume
    public let domain: Rect3D
    // padding in domain units
    public let domainPadding: EdgeInsets3D
    // an origin + size of output volume domain is mapped into
    public let bounds: Rect3D
    // scale used to fit domain into bounds
    public let scale: Size3D

    public init(
        domain: Rect3D,
        domainPadding: EdgeInsets3D,
        bounds: Rect3D,
        scale: Size3D
    ) {
        self.domain = domain
        self.domainPadding = domainPadding
        self.bounds = bounds
        self.scale = scale
    }

    public var description: String {
        "domain: \(domain)"
    }
}

public extension DomainScale3D {
    private var paddedDomain: Rect3D { domain.padded(domainPadding) }
    private var paddedDomainX: DoubleRange { paddedDomain.min.x ... paddedDomain.max.x }
    private var paddedDomainY: DoubleRange { paddedDomain.min.y ... paddedDomain.max.y }
    private var paddedDomainZ: DoubleRange { paddedDomain.min.z ... paddedDomain.max.z }
    private var paddedDoundsX: DoubleRange { bounds.min.x ... bounds.max.x }
    private var paddedDoundsY: DoubleRange { bounds.min.y ... bounds.max.y }
    private var paddedDoundsZ: DoubleRange { bounds.min.z ... bounds.max.z }

    private var boundsX: DoubleRange { bounds.min.x ... bounds.max.x }
    private var boundsY: DoubleRange { bounds.min.y ... bounds.max.y }
    private var boundsZ: DoubleRange { bounds.min.z ... bounds.max.z }

    func boundsPointFrom(domain: Point3D) -> Point3D {
        Point3D(x: boundsXFrom(domainX: domain.x),
                y: boundsYFrom(domainY: domain.y),
                z: boundsZFrom(domainZ: domain.z))
    }

    func boundsXFrom(domainX x: Double) -> Double {
        boundsX.lerp(x, in: paddedDomainX)
    }

    func boundsYFrom(domainY y: Double) -> Double {
        boundsY.lerp(y, in: paddedDomainY)
    }

    func boundsZFrom(domainZ z: Double) -> Double {
        boundsZ.lerp(z, in: paddedDomainZ)
    }
}

/// wrapper around logic to scale domain into (proposed) size
public struct DomainScaleFor: Sendable {
    let gridScaleFor: @Sendable (_ domain: Rect3D, _ domainPadding: EdgeInsets3D, _ size: Size3D) -> DomainScale3D

    public init(gridScaleFor: @Sendable @escaping (_ domain: Rect3D, _ domainPadding: EdgeInsets3D, _ size: Size3D) -> DomainScale3D) {
        self.gridScaleFor = gridScaleFor
    }

    public func callAsFunction(domain: Rect3D, domainPadding: EdgeInsets3D, size: Size3D) -> DomainScale3D {
        gridScaleFor(domain, domainPadding, size)
    }

    /// calculates uniformly sclaed fit with some padding so we can draw stuff at the edges and stay inside the volume
    public static let uniformFit = DomainScaleFor { domain, domainPadding, size in
        let paddedDomain = domain.padded(domainPadding)
        let sizeThatFits = AspectRatioMath.scaledToFit(
            paddedDomain.size,
            into: size,
            maxScale: nil
        )
        let bounds = Rect3D(center: .zero, size: sizeThatFits)
        let scale = AspectRatioMath.scaleToFit(paddedDomain.size, into: bounds.size)

        return DomainScale3D(
            domain: domain,
            domainPadding: domainPadding,
            bounds: bounds,
            scale: .one * scale
        )
    }
}
