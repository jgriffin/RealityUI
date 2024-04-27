//
// Created by John Griffin on 4/22/24
//

import Foundation

@resultBuilder
public enum ChartBuilder {
    public static func buildBlock() -> EmptyChartContent { EmptyChartContent() }

    public static func buildBlock<Content: ChartContent>(_ content: Content) -> Content { content }

    public static func buildBlock(_ contents: any ChartContent...) -> ChartTupleContent {
        ChartTupleContent(contents: contents)
    }

    public static func buildExpression<Content: ChartContent>(_ expression: Content) -> Content { expression }

//    public static func buildArray(_ contents: [Content]) -> Content { contents }

    public static func buildEither<Content: ChartContent>(first content: Content) -> Content { content }

    public static func buildEither<Content: ChartContent>(second content: Content) -> Content { content }

    public static func buildIf<Content: ChartContent>(_ content: Content?) -> Content? { content }
}

public extension ChartBuilder {
    static func build<Content: ChartContent>(@ChartBuilder contents: () -> Content) -> Content {
        contents()
    }
}
