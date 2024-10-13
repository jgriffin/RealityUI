//
// Created by John Griffin on 4/21/24
//

import RealityKit
import RealityUI
import Spatial

public struct Chart3D<Content: Chart3DContent>: Chart3DContent, View3D, CustomView3D {
    public var content: Content

    public init(@Chart3DBuilder content: () -> Content) {
        self.content = content()
    }

    public nonisolated var description: String {
        "\(Self.self)"
    }
}

public extension Chart3D {
    func axisMarks(_: Environment3D) -> (x: AnyAxis3DContent, y: AnyAxis3DContent, z: AnyAxis3DContent) {
        (
            x: Axis3DMarks(values: .strideBy(stepSize: 0.1), content: { _ in Axis3DGridLine() })
                .eraseToAnyAxis3DContent(),
            y: Axis3DMarks(values: .strideBy(stepSize: 0.1), content: { _ in Axis3DGridLine() })
                .eraseToAnyAxis3DContent(),
            z: Axis3DMarks(values: .strideBy(stepSize: 0.1), content: { _ in Axis3DGridLine() })
                .eraseToAnyAxis3DContent()
        )
    }

    // MARK: - CustomChartContent

    func plottableDomains() -> PlottableDomains {
        content.plottableDomains()
    }

    func renderView(_ proxy: Chart3DProxy, _ env: Chart3DEnvironment) -> some View3D {
        Stack3D {
            content.renderView(proxy, env)
        }
    }

    // MARK: - View3D

    func customSizeFor(_ proposed: ProposedSize3D, _: Environment3D) -> Size3D {
        proposed.sizeOrDefault
    }

    func customRenderWithSize(_ size: Size3D, _ proposed: Size3D, _ env: Environment3D) -> Entity {
        let chartEnv = Chart3DEnvironment()
        let domains = plottableDomains()
        let proxy = Chart3DProxy(chartSize: size, domains: domains)
        let marks = axisMarks(env)

        let view = renderView(proxy, chartEnv)
            .overlay {
                Stack3D {
                    marks.x.renderView(proxy.xDimensionProxy, chartEnv)
                    marks.y.renderView(proxy.yDimensionProxy, chartEnv)
                        .foreground(.color(.red))
                    marks.z.renderView(proxy.zDimensionProxy, chartEnv)
                        .foreground(.color(.green))
                }
            }

        return view
            .renderWithSize(size, proposed, env)
    }
}
