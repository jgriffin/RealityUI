//
// Created by John Griffin on 4/18/24
//

import Foundation

@resultBuilder
public enum View3DBuilder {
    public static func buildBlock() -> EmptyView3D { EmptyView3D() }
    public static func buildBlock<Content: View3D>(_ content: Content) -> Content { content }
    public static func buildBlock<each C: View3D>(_ content: repeat each C) -> TupleView3D< repeat each C> {
        TupleView3D((repeat each content))
    }

    public static func buildExpression<Content: View3D>(_ expression: Content) -> Content {
        expression
    }

    public static func buildEither<First: View3D, Second: View3D>(
        first content: First
    ) -> _Conditional3D<First, Second> {
        .first(content)
    }

    public static func buildEither<First: View3D, Second: View3D>(
        second content: Second
    ) -> _Conditional3D<First, Second> {
        .second(content)
    }

    public static func buildIf<Content: View3D>(
        _ content: Content?
    ) -> _Conditional3D<Content, EmptyView3D> {
        content.map { .first($0) } ?? .second(EmptyView3D())
    }
}

public extension View3DBuilder {
    static func build<Content: View3D>(@View3DBuilder content: () -> Content) -> Content {
        content()
    }
}
