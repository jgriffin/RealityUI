//
// Created by John Griffin on 4/26/24
//

import RealityKit

// MARK: - RealityUIComponent

public struct RealityUIComponent: Component, CustomStringConvertible {
    public static let registerOnce: Void = { RealityUIComponent.registerComponent() }()

    public var content: any RealityContentProtocol

    public init(_ content: any RealityContentProtocol) {
        self.content = content
    }

    public var description: String { "\(content.description)" }
    public static let componentName = "RealityUI"
}

public extension Entity {
    var realityUI: RealityUIComponent? {
        get { components[RealityUIComponent.self] }
        set { components[RealityUIComponent.self] = newValue }
    }

    var View3D: (any RealityContentProtocol)? { realityUI?.content }
}

// MARK: - RealityContentType

public struct RealityContentType: Hashable, CustomStringConvertible {
    let id: ObjectIdentifier
    public let description: String

    public init<T: View3D>(_: T.Type = T.self) {
        id = ObjectIdentifier(T.self)
        description = String("\(T.self)".prefix { ch in ch != "<" })
    }
}

public extension View3D {
    static var contentType: RealityContentType { RealityContentType(Self.self) }
    var contentType: RealityContentType { Self.contentType }
}

// MARK: - RealityUIContentComponentProtocol

public protocol RealityContentProtocol: CustomStringConvertible {
    var type: RealityContentType { get }
    func isEqual(_ other: Self) -> Bool

    var hideChildDescriptions: Bool { get }
}

public extension RealityContentProtocol {
    func isEqual(_ other: any RealityContentProtocol) -> Bool {
        guard let other = other as? Self else { return false }
        return isEqual(other)
    }
}

public extension RealityContentProtocol {
    static func content<T: View3D, Value>(
        _: T.Type = T.self,
        _ value: Value,
        hideChildDescriptions: Bool
    ) -> Self where Self == RealityContentValue<Value> {
        RealityContentValue(T.contentType, value: value, hideChildDescription: hideChildDescriptions)
    }
}

// MARK: - RealityContentValue

public struct RealityContentValue<Value>: RealityContentProtocol, CustomStringConvertible {
    public let type: RealityContentType
    public let value: Value
    public let hideChildDescriptions: Bool

    public init(_ type: RealityContentType, value: Value, hideChildDescription: Bool) {
        self.type = type
        self.value = value
        hideChildDescriptions = hideChildDescription
    }

    public var description: String {
        [
            "\(type)",
            value is Void ? nil : "\(value)",
        ].compactMap { $0 }.joined(separator: " ")
    }
}

public extension RealityContentValue {
    func isEqual(_ other: RealityContentValue<Value>) -> Bool where Value: Equatable {
        value == other.value
    }

    func isEqual(_: RealityContentValue<Value>) -> Bool { false }
}
