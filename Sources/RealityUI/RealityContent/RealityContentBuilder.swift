//
// Created by John Griffin on 4/18/24
//

import Foundation

@resultBuilder
public enum RealityContentBuilder {
    public static func buildBlock() -> EmptyContent { EmptyContent() }
    public static func buildBlock<Content: RealityContent>(_ content: Content) -> Content { content }
    public static func buildBlock<each C: RealityContent>(_ content: repeat each C) -> RealityTuple< repeat each C> {
        RealityTuple((repeat each content))
    }

    public static func buildExpression<Content: RealityContent>(_ expression: Content) -> Content {
        expression
    }

    public static func buildEither<First: RealityContent, Second: RealityContent>(
        first content: First
    ) -> ConditionalRealityContent<First, Second> {
        .first(content)
    }

    public static func buildEither<First: RealityContent, Second: RealityContent>(
        second content: Second
    ) -> ConditionalRealityContent<First, Second> {
        .second(content)
    }

    public static func buildIf<Content: RealityContent>(
        _ content: Content?
    ) -> ConditionalRealityContent<Content, EmptyContent> {
        content.map { .first($0) } ?? .second(EmptyContent())
    }
}

public extension RealityContentBuilder {
    static func build<Content: RealityContent>(@RealityContentBuilder content: () -> Content) -> Content {
        content()
    }
}
