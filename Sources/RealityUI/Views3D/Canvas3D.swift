//
// Created by John Griffin on 4/29/24
//

import RealityKit
import Spatial

public struct Canvas3D<Content: View3D>: View3D {
    let layoutView: LayoutView3D<CanvasLayout3D, Content>

    public init(
        alignment: Alignment3D = .center,
        @View3DBuilder content: () -> Content
    ) {
        layoutView = LayoutView3D(
            .canvas(alignment: alignment),
            content: content
        )
    }

    public var body: some View3D {
        layoutView
    }
}
