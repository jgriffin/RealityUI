//
// Created by John Griffin on 4/22/24
//

public struct Chart3DEnvironment {
    private var values: [ObjectIdentifier: Any]

    init(values: [ObjectIdentifier: Any]) {
        self.values = values
    }

    public init() {
        values = [:]
    }
}

public extension Chart3DEnvironment {
    subscript<K: ChartEnvironmentKey>(_: K.Type) -> K.Value {
        get {
            values[ObjectIdentifier(K.Type.self)] as? K.Value ?? K.defaultValue
        }
        set {
            values[ObjectIdentifier(K.Type.self)] = newValue
        }
    }

    func merging(_ other: Chart3DEnvironment) -> Chart3DEnvironment {
        .init(values: values.merging(other.values, uniquingKeysWith: { _, rhs in rhs }))
    }
}

public protocol ChartEnvironmentKey {
    associatedtype Value

    static var defaultValue: Self.Value { get }
}
