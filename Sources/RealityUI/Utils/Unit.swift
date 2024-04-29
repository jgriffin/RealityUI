//
// Created by John Griffin on 4/28/24
//

import Spatial

extension BinaryFloatingPoint {
    static var unitZero: Self { 0.0 }
    static var unitCenter: Self { 0.5 }
    static var unitOne: Self { 1.0 }
}

public extension Vector3D {
    static let center = Self(x: .unitCenter, y: .unitCenter, z: .unitCenter)
    static let bottom = Self(x: .unitCenter, y: .unitZero, z: .unitCenter)
    static let bottomBack = Self(x: .unitCenter, y: .unitZero, z: .unitZero)
    static let bottomFront = Self(x: .unitCenter, y: .unitZero, z: .unitOne)
    static let bottomLeading = Self(x: .unitZero, y: .unitZero, z: .unitCenter)
    static let bottomLeadingBack = Self(x: .unitZero, y: .unitZero, z: .unitZero)
    static let bottomLeadingFront = Self(x: .unitZero, y: .unitZero, z: .unitOne)
    static let bottomTrailing = Self(x: .unitOne, y: .unitZero, z: .unitCenter)
    static let bottomTrailingBack = Self(x: .unitOne, y: .unitZero, z: .unitZero)
    static let bottomTrailingFront = Self(x: .unitOne, y: .unitZero, z: .unitOne)
    static let leading = Self(x: .unitZero, y: .unitCenter, z: .unitCenter)
    static let leadingBack = Self(x: .unitZero, y: .unitCenter, z: .unitZero)
    static let leadingFront = Self(x: .unitZero, y: .unitCenter, z: .unitOne)
    static let top = Self(x: .unitCenter, y: .unitOne, z: .unitCenter)
    static let topBack = Self(x: .unitCenter, y: .unitOne, z: .unitZero)
    static let topFront = Self(x: .unitCenter, y: .unitOne, z: .unitOne)
    static let topLeading = Self(x: .unitZero, y: .unitOne, z: .unitCenter)
    static let topLeadingBack = Self(x: .unitZero, y: .unitOne, z: .unitZero)
    static let topLeadingFront = Self(x: .unitZero, y: .unitOne, z: .unitOne)
    static let topTrailing = Self(x: .unitOne, y: .unitOne, z: .unitCenter)
    static let topTrailingBack = Self(x: .unitOne, y: .unitOne, z: .unitZero)
    static let topTrailingFront = Self(x: .unitOne, y: .unitOne, z: .unitOne)
    static let trailing = Self(x: .unitOne, y: .unitCenter, z: .unitCenter)
    static let trailingBack = Self(x: .unitOne, y: .unitCenter, z: .unitZero)
    static let trailingFront = Self(x: .unitOne, y: .unitCenter, z: .unitOne)
    static let back = Self(x: .unitCenter, y: .unitCenter, z: .unitZero)
    static let front = Self(x: .unitCenter, y: .unitCenter, z: .unitOne)
}

public extension Point3D {
    static let center = Self(x: .unitCenter, y: .unitCenter, z: .unitCenter)
    static let bottom = Self(x: .unitCenter, y: .unitZero, z: .unitCenter)
    static let bottomBack = Self(x: .unitCenter, y: .unitZero, z: .unitZero)
    static let bottomFront = Self(x: .unitCenter, y: .unitZero, z: .unitOne)
    static let bottomLeading = Self(x: .unitZero, y: .unitZero, z: .unitCenter)
    static let bottomLeadingBack = Self(x: .unitZero, y: .unitZero, z: .unitZero)
    static let bottomLeadingFront = Self(x: .unitZero, y: .unitZero, z: .unitOne)
    static let bottomTrailing = Self(x: .unitOne, y: .unitZero, z: .unitCenter)
    static let bottomTrailingBack = Self(x: .unitOne, y: .unitZero, z: .unitZero)
    static let bottomTrailingFront = Self(x: .unitOne, y: .unitZero, z: .unitOne)
    static let leading = Self(x: .unitZero, y: .unitCenter, z: .unitCenter)
    static let leadingBack = Self(x: .unitZero, y: .unitCenter, z: .unitZero)
    static let leadingFront = Self(x: .unitZero, y: .unitCenter, z: .unitOne)
    static let top = Self(x: .unitCenter, y: .unitOne, z: .unitCenter)
    static let topBack = Self(x: .unitCenter, y: .unitOne, z: .unitZero)
    static let topFront = Self(x: .unitCenter, y: .unitOne, z: .unitOne)
    static let topLeading = Self(x: .unitZero, y: .unitOne, z: .unitCenter)
    static let topLeadingBack = Self(x: .unitZero, y: .unitOne, z: .unitZero)
    static let topLeadingFront = Self(x: .unitZero, y: .unitOne, z: .unitOne)
    static let topTrailing = Self(x: .unitOne, y: .unitOne, z: .unitCenter)
    static let topTrailingBack = Self(x: .unitOne, y: .unitOne, z: .unitZero)
    static let topTrailingFront = Self(x: .unitOne, y: .unitOne, z: .unitOne)
    static let trailing = Self(x: .unitOne, y: .unitCenter, z: .unitCenter)
    static let trailingBack = Self(x: .unitOne, y: .unitCenter, z: .unitZero)
    static let trailingFront = Self(x: .unitOne, y: .unitCenter, z: .unitOne)
    static let back = Self(x: .unitCenter, y: .unitCenter, z: .unitZero)
    static let front = Self(x: .unitCenter, y: .unitCenter, z: .unitOne)
}
