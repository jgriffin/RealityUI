//
// Created by John Griffin on 4/22/24
//

import Foundation

@resultBuilder
public enum ChartBuilder {
    public typealias Content = ChartContent

    public static func buildBlock() -> EmptyChartContent { EmptyChartContent() }
    public static func buildBlock<C: Content>(_ content: C) -> C { content }
    public static func buildBlock<each C: Content>(_ content: repeat each C) -> ChartTuple< repeat (each C)> {
        ChartTuple((repeat each content))
    }

    public static func buildExpression<C: Content>(_ expression: C) -> C {
        expression
    }

    public static func buildEither<First: Content, Second: Content>(first content: First) -> ConditionalChartContent<First, Second> {
        .first(content)
    }

    public static func buildEither<First: Content, Second: Content>(second content: Second) -> ConditionalChartContent<First, Second> {
        .second(content)
    }

    public static func buildIf<C: Content>(_ content: C?) -> ConditionalChartContent<C, EmptyChartContent>? {
        content.map { .first($0) } ?? .second(EmptyChartContent())
    }
}

public extension ChartBuilder {
    static func build<Content: ChartContent>(@ChartBuilder contents: () -> Content) -> Content {
        contents()
    }
}
