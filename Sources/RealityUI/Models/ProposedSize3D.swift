//
// Created by John Griffin on 4/18/24
//

import Spatial

public struct ProposedSize3D {
    public var width: Double?
    public var height: Double?
    public var depth: Double?

    public init(width: Double?, height: Double?, depth: Double?) {
        self.width = width
        self.height = height
        self.depth = depth
    }
}

public extension ProposedSize3D {
    init(_ size: Size3D) {
        self.init(width: size.width, height: size.height, depth: size.depth)
    }

    func sizeOr(_ size: Size3D) -> Size3D {
        Size3D(width: width ?? size.width,
               height: height ?? size.height,
               depth: depth ?? size.depth)
    }

    var sizeOrInfinite: Size3D { sizeOr(Self.infiniteSize) }
    var sizeOrDefault: Size3D { sizeOr(Self.defaultSize) }

    static let infiniteSize = Size3D(width: .greatestFiniteMagnitude,
                                     height: .greatestFiniteMagnitude,
                                     depth: .greatestFiniteMagnitude)

    static let defaultSize = Size3D(width: 0.10,
                                    height: 0.10,
                                    depth: 0.10)
}
