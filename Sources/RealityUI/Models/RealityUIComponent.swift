//
// Created by John Griffin on 4/26/24
//

import RealityKit

// MARK: - RealityUIComponent

public struct RealityUIComponent: Component, CustomDebugStringConvertible {
    public static let registerOnce: Void = { RealityUIComponent.registerComponent() }()

    public var content: any RealityContentProtocol

    public init(_ content: any RealityContentProtocol) {
        self.content = content
    }

    public var debugDescription: String { "RealityUI: \(content.type)" }

    public static let componentName = "RealityUI"
}

public extension Entity {
    var realityUI: RealityUIComponent? {
        get { components[RealityUIComponent.self] }
        set { components[RealityUIComponent.self] = newValue }
    }

    var realityContent: (any RealityContentProtocol)? { realityUI?.content }
}

// MARK: - RealityContentType

public struct RealityContentType: Hashable, CustomStringConvertible {
    let id: ObjectIdentifier
    public let description: String

    public init<T: RealityContent>(_: T.Type = T.self) {
        id = ObjectIdentifier(T.self)
        description = "\(T.self)"
    }
}

public extension RealityContent {
    static var contentType: RealityContentType { RealityContentType(Self.self) }
    var contentType: RealityContentType { RealityContentType(Self.self) }
}

// MARK: - RealityUIContentComponentProtocol

public protocol RealityContentProtocol {
    var type: RealityContentType { get }
    func isEqual(_ other: Self) -> Bool
}

public extension RealityContentProtocol {
    func isEqual(_ other: any RealityContentProtocol) -> Bool {
        guard let other = other as? Self else { return false }
        return isEqual(other)
    }
}

public extension RealityContentProtocol {
    static func value<T: RealityContent, Value>(
        _: T.Type = T.self,
        _ value: Value
    ) -> Self where Self == RealityContentValue<Value> {
        RealityContentValue(T.contentType, value: value)
    }
}

// MARK: - RealityContentValue

public struct RealityContentValue<Value>: RealityContentProtocol, CustomDebugStringConvertible {
    public let type: RealityContentType
    public let value: Value

    public init(_ contentType: RealityContentType, value: Value) {
        type = contentType
        self.value = value
    }

    public var debugDescription: String {
        "RealityContent \(type) \(value)"
    }
}

public extension RealityContentValue {
    func isEqual(_ other: RealityContentValue<Value>) -> Bool where Value: Equatable {
        value == other.value
    }

    func isEqual(_: RealityContentValue<Value>) -> Bool { false }
}
