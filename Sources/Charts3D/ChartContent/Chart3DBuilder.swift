//
// Created by John Griffin on 4/22/24
//

import Foundation

@resultBuilder
@MainActor public enum Chart3DBuilder {
    public static func buildBlock() -> EmptyChart3DContent { EmptyChart3DContent() }
    public static func buildBlock<C: Chart3DContent>(_ content: C) -> C { content }
    public static func buildBlock<each C: Chart3DContent>(_ content: repeat each C) -> TupleChart3DContent< repeat each C> {
        TupleChart3DContent((repeat each content))
    }

    public static func buildExpression<C: Chart3DContent>(_ expression: C) -> C {
        expression
    }

    public static func buildEither<First: Chart3DContent, Second: Chart3DContent>(first content: First) -> _ConditionalChart3DContent<First, Second> {
        .first(content)
    }

    public static func buildEither<First: Chart3DContent, Second: Chart3DContent>(second content: Second) -> _ConditionalChart3DContent<First, Second> {
        .second(content)
    }

    public static func buildIf<C: Chart3DContent>(_ content: C?) -> _ConditionalChart3DContent<C, EmptyChart3DContent> {
        content.map { .first($0) } ?? .second(EmptyChart3DContent())
    }
}

public extension Chart3DBuilder {
    static func build<Content: Chart3DContent>(@Chart3DBuilder contents: () -> Content) -> Content {
        contents()
    }
}
