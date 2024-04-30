//
// Created by John Griffin on 4/21/24
//

import RealityKit
import RealityUI
import Spatial

public struct Chart3D<Content: Chart3DContent>: Chart3DContent, CustomChart3DContent, View3D, CustomView3D {
    public var content: Content

    public init(@Chart3DBuilder content: () -> Content) {
        self.content = content()
    }
}

public extension Chart3D {
    // MARK: - CustomChartContent

    func customPlottableDomains() -> PlottableDomains {
        content.plottableDomains()
    }

    func customRender(_: Chart3DEnvironment) -> AnyView3D {
        content.render(.init())
    }

    // MARK: - View3D

    func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        proposed.sizeOrDefault
    }

    func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        customRender(Chart3DEnvironment())
            .renderWithSize(size, env)
    }
}
