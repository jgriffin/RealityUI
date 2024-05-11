//
// Created by John Griffin on 4/22/24
//

import Charts
import Foundation

// MARK: - PlottableDomains

/// (Dictionary) collection of domains
public struct PlottableDomains: CustomStringConvertible {
    var x: [ObjectIdentifier: any PlottableDomain]
    var y: [ObjectIdentifier: any PlottableDomain]
    var z: [ObjectIdentifier: any PlottableDomain]

    public init() {
        x = [:]
        y = [:]
        z = [:]
    }

    public init(x: some PlottableDomain, y: some PlottableDomain, z: some PlottableDomain) {
        self.x = [x.id: x]
        self.y = [y.id: y]
        self.z = [z.id: z]
    }

    public init<X: Plottable, Y: Plottable, Z: Plottable>(
        x: Plottable3DValue<X>...,
        y: Plottable3DValue<Y>...,
        z: Plottable3DValue<Z>...
    ) {
        self.init(
            x: PlottableDomainValues(x.map(\.value)),
            y: PlottableDomainValues(y.map(\.value)),
            z: PlottableDomainValues(z.map(\.value))
        )
    }

    // MARK: merge

    static func merge(
        _ d: inout [ObjectIdentifier: any PlottableDomain],
        with other: any PlottableDomain
    ) {
        guard let domain = d[other.id] else {
            d[other.id] = other
            return
        }

        guard let merged = domain.merging(other) else {
            assertionFailure("same type didn't merge ...")
            d[other.id] = other
            return
        }

        d[other.id] = merged
    }

    static func merge(
        _ d: inout [ObjectIdentifier: any PlottableDomain],
        with others: some Sequence<any PlottableDomain>
    ) {
        others.forEach { merge(&d, with: $0) }
    }

    public mutating func merge(_ other: PlottableDomains) {
        Self.merge(&x, with: other.x.values)
        Self.merge(&y, with: other.y.values)
        Self.merge(&z, with: other.z.values)
    }

    public func merging(_ other: PlottableDomains) -> PlottableDomains {
        modify(self) {
            $0.merge(other)
        }
    }

    public var description: String {
        "x: \(xDomains) y:\(yDomains) z:\(zDomains)"
    }

    // MARK: - dimension domains

    public var xDomains: [any PlottableDomain] { x.values.sorted { lhs, rhs in lhs.id < rhs.id } }
    public var yDomains: [any PlottableDomain] { y.values.sorted { lhs, rhs in lhs.id < rhs.id } }
    public var zDomains: [any PlottableDomain] { z.values.sorted { lhs, rhs in lhs.id < rhs.id } }

    public func xDomain<P: Plottable>(_: P.Type) -> [P] { x.values.flatMap { ($0.values.compactMap { $0 as? P }) } }
    public func yDomain<P: Plottable>(_: P.Type) -> [P] { y.values.flatMap { ($0.values.compactMap { $0 as? P }) } }
    public func zDomain<P: Plottable>(_: P.Type) -> [P] { z.values.flatMap { ($0.values.compactMap { $0 as? P }) } }

    public var numericDomains: PlottableNumericRanges {
        (x: Self.plottableNumericRangeFrom(x.values),
         y: Self.plottableNumericRangeFrom(y.values),
         z: Self.plottableNumericRangeFrom(z.values))
    }

    static func plottableNumericRangeFrom(_ domains: some Sequence<any PlottableDomain>) -> PlottableNumericRange? {
        let combined = domains.flatMap { $0.values.compactMap { PlottableNumeric.from($0) }}
        guard let min = combined.min(), let max = combined.max() else { return nil }
        return min ... max
    }
}

// MARK: - PlottableDomain

/// protocol for generic collections of domains
public protocol PlottableDomain<Value>: Identifiable, CustomStringConvertible where ID == ObjectIdentifier {
    associatedtype Value: Plottable

    var values: [Value] { get }
    func merging(_ value: any PlottableDomain) -> Self?
}

public extension PlottableDomain {
    var id: ObjectIdentifier { ObjectIdentifier(Self.self) }

    var description: String { "\(String(describing: Value.self)): \(values)" }
}

public struct PlottableDomainValues<Value: Plottable>: PlottableDomain, CustomStringConvertible {
    public typealias Value = Value

    public var values: [Value]

    public init(_ values: [Value]) {
        self.values = values
    }

    public init(_ values: Value...) {
        self.init(values)
    }

    public init(_ values: Plottable3DValue<Value>...) {
        self.init(values.map(\.value))
    }

    public func merging(_ other: any PlottableDomain) -> PlottableDomainValues<Value>? {
        guard let o = other as? Self else { return nil }
        return Self(values + o.values)
    }
}
