//
// Created by John Griffin on 5/25/24
//

import RealityKit
import Spatial
import SwiftUI

public struct _BorderBox3D: View3D, CustomView3D {
    public func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        proposed.sizeOrDefault
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        let material = env.foregroundMaterial
        let bounds = Rect3D(center: .zero, size: size)

        let linesPoints: [[Point3D]] = [
            [.bottomLeadingBack, .bottomTrailingBack, .bottomTrailingFront, .bottomLeadingFront, .bottomLeadingBack],
            [.topLeadingBack, .topTrailingBack, .topTrailingFront, .topLeadingFront, .topLeadingBack],
            [.bottomLeadingBack, .topLeadingBack],
            [.bottomTrailingBack, .topTrailingBack],
            [.bottomTrailingFront, .topTrailingFront],
            [.bottomLeadingFront, .topLeadingFront],
        ].map { linePoints in
            linePoints.map(bounds.interpolate)
        }

        let borderView = Stack3D(alignment: .center) {
            ForEach3D(linesPoints, id: \.self) { linePoints in
                Line3D(linePoints)
            }
            .foreground(material)
        }
        return makeEntity(
            value: "_Border3D",
            children: borderView
                .customRenderWithSize(size, env)
        )
    }
}

#if os(visionOS)

    #Preview {
        RealityUIView {
            _BorderBox3D()
        }
    }

#endif
