//
// Created by John Griffin on 4/20/24
//

import Spatial

public struct EdgeInsets3D {
    var leading: Double
    var trailing: Double
    var top: Double
    var bottom: Double
    var front: Double
    var back: Double

    public init(
        leading: Double = 0,
        trailing: Double = 0,
        top: Double = 0,
        bottom: Double = 0,
        front: Double = 0,
        back: Double = 0
    ) {
        self.leading = leading
        self.trailing = trailing
        self.top = top
        self.bottom = bottom
        self.front = front
        self.back = back
    }

    public init(
        horizontal: Double = 0,
        vertical: Double = 0,
        depth: Double = 0
    ) {
        self.init(
            leading: horizontal, trailing: horizontal,
            top: vertical, bottom: vertical,
            front: depth, back: depth
        )
    }

    public init(_ all: Double) {
        self.init(
            leading: all, trailing: all,
            top: all, bottom: all,
            front: all, back: all
        )
    }

    public static let zero: EdgeInsets3D = .init()

    /// offset for origin
    public var leadingBottomBack: Vector3D {
        Vector3D(x: leading, y: bottom, z: back)
    }

    public var size: Size3D {
        Size3D(width: leading + trailing, height: top + bottom, depth: front + back)
    }
}

public extension Rect3D {
    func padded(_ padding: EdgeInsets3D) -> Rect3D {
        Rect3D(origin: origin - padding.leadingBottomBack, size: size + padding.size)
    }
}

public extension Size3D {
    func padded(_ padding: EdgeInsets3D) -> Size3D {
        self + padding.size
    }
}
