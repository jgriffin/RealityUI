//
// Created by John Griffin on 4/18/24
//

import Foundation

@resultBuilder
public enum RealityContentsBuilder {
    public typealias Content = any RealityContent

    public static func buildBlock(_ contents: [Content]...) -> [Content] {
        contents.flatMap { $0 }
    }

    public static func buildExpression(_ expression: Content) -> [Content] { [expression] }

    public static func buildExpression(_ expression: [Content]) -> [Content] { expression }

    public static func buildArray(_ contents: [Content]) -> [Content] { contents }

    public static func buildEither(first content: Content) -> [Content] { [content] }

    public static func buildEither(second content: Content) -> [Content] { [content] }

    public static func buildOptional(_ contents: [Content]?) -> [Content] {
        contents ?? []
    }
}

public extension RealityContentsBuilder {
    static func build(@RealityContentsBuilder contents: () -> [Content]) -> [Content] {
        contents()
    }
}
