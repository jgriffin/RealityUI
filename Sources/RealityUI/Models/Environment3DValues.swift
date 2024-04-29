//
// Created by John Griffin on 4/5/24
//

import Foundation

public struct Environment3DValues {
    private var values: [ObjectIdentifier: Any]

    init(values: [ObjectIdentifier: Any]) {
        self.values = values
    }

    public init() {
        values = [:]
    }
}

public extension Environment3DValues {
    subscript<K: Environment3DKey>(_: K.Type) -> K.Value {
        get {
            values[ObjectIdentifier(K.Type.self)] as? K.Value ?? K.defaultValue
        }
        set {
            values[ObjectIdentifier(K.Type.self)] = newValue
        }
    }

    func merging(_ other: Environment3DValues) -> Environment3DValues {
        .init(values: values.merging(other.values, uniquingKeysWith: { _, rhs in rhs }))
    }
}

public protocol Environment3DKey {
    associatedtype Value

    static var defaultValue: Self.Value { get }
}
