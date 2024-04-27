//
// Created by John Griffin on 4/18/24
//

import Spatial

public protocol Alignment3DID {
    static func defaultValue(in context: Size3D) -> Double
}

public struct Alignment3D: Equatable {
    public var horizontal: HorizontalAlignment3D
    public var vertical: VerticalAlignment3D
    public var depth: DepthAlignment3D

    public init(
        _ horizontal: HorizontalAlignment3D,
        _ vertical: VerticalAlignment3D,
        _ depth: DepthAlignment3D
    ) {
        self.horizontal = horizontal
        self.vertical = vertical
        self.depth = depth
    }

    public func point(for size: Size3D) -> Point3D {
        Point3D(
            x: horizontal.alignmentID.defaultValue(in: size),
            y: vertical.alignmentID.defaultValue(in: size),
            z: depth.alignmentID.defaultValue(in: size)
        )
    }

    public func offset(parent: Size3D, child: Size3D) -> Vector3D {
        point(for: parent) - point(for: child)
    }
}

public struct HorizontalAlignment3D: Equatable {
    public var alignmentID: Alignment3DID.Type

    public static func == (lhs: HorizontalAlignment3D, rhs: HorizontalAlignment3D) -> Bool {
        lhs.alignmentID == rhs.alignmentID
    }
}

public struct VerticalAlignment3D: Equatable {
    public var alignmentID: Alignment3DID.Type

    public static func == (lhs: VerticalAlignment3D, rhs: VerticalAlignment3D) -> Bool {
        lhs.alignmentID == rhs.alignmentID
    }
}

public struct DepthAlignment3D: Equatable {
    public var alignmentID: Alignment3DID.Type

    public static func == (lhs: DepthAlignment3D, rhs: DepthAlignment3D) -> Bool {
        lhs.alignmentID == rhs.alignmentID
    }
}

// MARK: - values

public extension Alignment3D {
    static let center = Self(.center, .center, .center)
    static let bottom = Self(.center, .bottom, .center)
    static let bottomBack = Self(.center, .bottom, .back)
    static let bottomFront = Self(.center, .bottom, .front)
    static let bottomLeading = Self(.leading, .bottom, .center)
    static let bottomLeadingBack = Self(.leading, .bottom, .back)
    static let bottomLeadingFront = Self(.leading, .bottom, .front)
    static let bottomTrailing = Self(.trailing, .bottom, .center)
    static let bottomTrailingBack = Self(.trailing, .bottom, .back)
    static let bottomTrailingFront = Self(.trailing, .bottom, .front)
    static let leading = Self(.leading, .center, .center)
    static let leadingBack = Self(.leading, .center, .back)
    static let leadingFront = Self(.leading, .center, .front)
    static let top = Self(.center, .top, .center)
    static let topBack = Self(.center, .top, .back)
    static let topFront = Self(.center, .top, .front)
    static let topLeading = Self(.leading, .top, .center)
    static let topLeadingBack = Self(.leading, .top, .back)
    static let topLeadingFront = Self(.leading, .top, .front)
    static let topTrailing = Self(.trailing, .top, .center)
    static let topTrailingBack = Self(.trailing, .top, .back)
    static let topTrailingFront = Self(.trailing, .top, .front)
    static let trailing = Self(.trailing, .center, .center)
    static let trailingBack = Self(.trailing, .center, .back)
    static let trailingFront = Self(.trailing, .center, .front)
    static let back = Self(.center, .center, .back)
    static let front = Self(.center, .center, .front)
}

public extension HorizontalAlignment3D {
    static let leading = Self(alignmentID: HLeading.self)
    static let center = Self(alignmentID: HCenter.self)
    static let trailing = Self(alignmentID: HTrailing.self)

    private enum HLeading: Alignment3DID {
        public static func defaultValue(in context: Size3D) -> Double { -context.width / 2 }
    }

    private enum HCenter: Alignment3DID {
        public static func defaultValue(in _: Size3D) -> Double { 0 }
    }

    private enum HTrailing: Alignment3DID {
        public static func defaultValue(in context: Size3D) -> Double { context.width / 2 }
    }
}

public extension VerticalAlignment3D {
    static let top = Self(alignmentID: VTop.self)
    static let center = Self(alignmentID: VCenter.self)
    static let bottom = Self(alignmentID: VBottom.self)

    private enum VTop: Alignment3DID {
        public static func defaultValue(in context: Size3D) -> Double { context.height / 2 }
    }

    private enum VCenter: Alignment3DID {
        public static func defaultValue(in _: Size3D) -> Double { 0 }
    }

    private enum VBottom: Alignment3DID {
        public static func defaultValue(in context: Size3D) -> Double { -context.height / 2 }
    }
}

public extension DepthAlignment3D {
    static let front = Self(alignmentID: DFront.self)
    static let center = Self(alignmentID: DCenter.self)
    static let back = Self(alignmentID: DBack.self)

    private enum DFront: Alignment3DID {
        public static func defaultValue(in context: Size3D) -> Double { context.depth / 2 }
    }

    private enum DCenter: Alignment3DID {
        public static func defaultValue(in _: Size3D) -> Double { 0 }
    }

    private enum DBack: Alignment3DID {
        public static func defaultValue(in context: Size3D) -> Double { -context.depth / 2 }
    }
}
