//
// Created by John Griffin on 4/23/24
//

import Foundation

public protocol Plottable {
    associatedtype PrimitivePlottable: PlottablePrimitiveProtocol

    var primitivePlottable: PrimitivePlottable { get }
    init?(primitivePlottable: Self.PrimitivePlottable)
}

public protocol PlottablePrimitiveProtocol: Plottable where Self == Self.PrimitivePlottable {
    var primitivePlottable: Self { get }
    init?(primitivePlottable: PrimitivePlottable)
}

public extension PlottablePrimitiveProtocol {
    var primitivePlottable: Self { self }

    init?(primitivePlottable: PrimitivePlottable) {
        self = primitivePlottable
    }
}

extension PlottablePrimitiveProtocol {
    var typeId: ObjectIdentifier { ObjectIdentifier(Self.self) }
}

extension Float: PlottablePrimitiveProtocol {}
extension Int: PlottablePrimitiveProtocol {}
extension String: PlottablePrimitiveProtocol {}
