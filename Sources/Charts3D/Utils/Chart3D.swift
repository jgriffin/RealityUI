//
// Created by John Griffin on 4/21/24
//

import RealityKit
import RealityUI
import Spatial

public struct Chart3D<Content: ChartContent>: ChartContent, CustomChartContent, View3D, CustomView3D {
    public var content: Content

    public init(@ChartBuilder content: () -> Content) {
        self.content = content()
    }
}

public extension Chart3D {
    // MARK: - CustomChartContent

    func customPlottableDomains() -> PlottableDomains {
        content.plottableDomains()
    }

    func customRender(_: ChartEnvironment) -> AnyView3D {
        content.render(.init())
    }

    // MARK: - View3D

    func customSizeFor(_ proposed: ProposedSize3D) -> Size3D {
        proposed.sizeOrDefault
    }

    func customRender(_ context: RenderContext, size: Size3D) -> Entity {
        customRender(ChartEnvironment())
            .render(context, size: size)
    }
}
