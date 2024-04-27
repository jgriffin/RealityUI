//
// Created by John Griffin on 4/22/24
//

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

    public init(
        x: any PlottableDomain,
        y: any PlottableDomain,
        z: any PlottableDomain
    ) {
        self.x = [x.id: x]
        self.y = [y.id: y]
        self.z = [z.id: z]
    }

    public init<X: Plottable, Y: Plottable, Z: Plottable>(
        x: PlottableValue<X>...,
        y: PlottableValue<Y>...,
        z: PlottableValue<Z>...
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
        "TODO"
    }

    // MARK: - dimension domains

    public func xDomains() -> [any PlottableDomain] {
        x.values.sorted { lhs, rhs in lhs.id < rhs.id }
    }

    public func yDomains() -> [any PlottableDomain] {
        y.values.sorted { lhs, rhs in lhs.id < rhs.id }
    }

    public func zDomains() -> [any PlottableDomain] {
        z.values.sorted { lhs, rhs in lhs.id < rhs.id }
    }

    public func xDomain<P: Plottable>(_: P.Type) -> [P] {
        x.values
            .compactMap { $0 as? any PlottableDomain<P> }
            .flatMap(\.values)
    }

    public func yDomain<P: Plottable>(_: P.Type) -> [P] {
        y.values
            .compactMap { $0 as? any PlottableDomain<P> }
            .flatMap(\.values)
    }

    public func zDomain<P: Plottable>(_: P.Type) -> [P] {
        z.values
            .compactMap { $0 as? any PlottableDomain<P> }
            .flatMap(\.values)
    }
}

// MARK: - PlottableDomain

/// protocol for generic collections of domains
public protocol PlottableDomain<Value>: Identifiable where ID == ObjectIdentifier {
    associatedtype Value: Plottable

    var values: [Value] { get }
    func merging(_ value: any PlottableDomain) -> Self?
}

public extension PlottableDomain {
    var id: ObjectIdentifier { ObjectIdentifier(Self.self) }
}

public struct PlottableDomainValues<V: Plottable>: PlottableDomain {
    public typealias Value = V

    public var values: [V]

    public init(_ values: [V]) {
        self.values = values
    }

    public init(_ values: V...) {
        self.init(values)
    }

    public init(_ values: PlottableValue<V>...) {
        self.init(values.map(\.value))
    }

    public func merging(_ other: any PlottableDomain) -> PlottableDomainValues<V>? {
        guard let o = other as? Self else { return nil }
        return Self(values + o.values)
    }
}
