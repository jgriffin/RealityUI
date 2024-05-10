//
// Created by John Griffin on 4/22/24
//

import Charts
import Foundation

// MARK: - PlottableDomains

/// (Dictionary) collection of domains
public struct PlottableDomains: CustomStringConvertible {
    var x: [ObjectIdentifier: any DimensionDomain]
    var y: [ObjectIdentifier: any DimensionDomain]
    var z: [ObjectIdentifier: any DimensionDomain]

    public init() {
        x = [:]
        y = [:]
        z = [:]
    }

    public init(x: some DimensionDomain, y: some DimensionDomain, z: some DimensionDomain) {
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
            x: DimensionDomainValues(x.map(\.value)),
            y: DimensionDomainValues(y.map(\.value)),
            z: DimensionDomainValues(z.map(\.value))
        )
    }

    // MARK: merge

    static func merge(
        _ d: inout [ObjectIdentifier: any DimensionDomain],
        with other: any DimensionDomain
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
        _ d: inout [ObjectIdentifier: any DimensionDomain],
        with others: some Sequence<any DimensionDomain>
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

    public var xDomains: [any DimensionDomain] { x.values.sorted { lhs, rhs in lhs.id < rhs.id } }
    public var yDomains: [any DimensionDomain] { y.values.sorted { lhs, rhs in lhs.id < rhs.id } }
    public var zDomains: [any DimensionDomain] { z.values.sorted { lhs, rhs in lhs.id < rhs.id } }

    public func xDomain<P: Plottable>(_: P.Type) -> [P] { x.values.flatMap { ($0.values.compactMap { $0 as? P }) } }
    public func yDomain<P: Plottable>(_: P.Type) -> [P] { y.values.flatMap { ($0.values.compactMap { $0 as? P }) } }
    public func zDomain<P: Plottable>(_: P.Type) -> [P] { z.values.flatMap { ($0.values.compactMap { $0 as? P }) } }

    public var numericDomains: NumericDomains {
        (x: Self.numericDimensionRangeFrom(x.values),
         y: Self.numericDimensionRangeFrom(y.values),
         z: Self.numericDimensionRangeFrom(z.values))
    }

    static func numericDimensionRangeFrom(_ domains: some Sequence<any DimensionDomain>) -> NumericDimensionRange? {
        let combined = domains.flatMap { $0.values.compactMap { NumericDimension.from($0) }}
        guard let min = combined.min(), let max = combined.max() else { return nil }
        return min ... max
    }
}

// MARK: - DimensionDomain

/// protocol for generic collections of domains
public protocol DimensionDomain<Value>: Identifiable, CustomStringConvertible where ID == ObjectIdentifier {
    associatedtype Value: Plottable

    var values: [Value] { get }
    func merging(_ value: any DimensionDomain) -> Self?
}

public extension DimensionDomain {
    var id: ObjectIdentifier { ObjectIdentifier(Self.self) }

    var description: String { "\(String(describing: Value.self)): \(values)" }
}

public struct DimensionDomainValues<Value: Plottable>: DimensionDomain, CustomStringConvertible {
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

    public func merging(_ other: any DimensionDomain) -> DimensionDomainValues<Value>? {
        guard let o = other as? Self else { return nil }
        return Self(values + o.values)
    }
}
