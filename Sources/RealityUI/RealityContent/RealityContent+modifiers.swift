//
// Created by John Griffin on 4/18/24
//

import Spatial

public extension RealityContent {
    // MARK: - frame

    func frame(
        width: Double? = nil,
        height: Double? = nil,
        depth: Double? = nil,
        alignment: Alignment3D = .center
    ) -> some RealityContent {
        RealityFrame(
            content: self,
            width: width,
            height: height,
            depth: depth,
            alignment: alignment
        )
    }

    func frame(
        size: Size3D,
        alignment: Alignment3D = .center
    ) -> some RealityContent {
        RealityFrame(
            content: self,
            width: size.width,
            height: size.height,
            depth: size.depth,
            alignment: alignment
        )
    }

    // MARK: - padding

    func padding(_ insets: EdgeInsets3D) -> some RealityContent {
        RealityPadding(content: self, edgeInsets: insets)
    }

    func padding(_ all: Double) -> some RealityContent {
        RealityPadding(content: self, edgeInsets: .init(all: all))
    }

    // MARK: - offset

    func offset(_ offset: Vector3D) -> some RealityContent {
        RealityOffset(content: self, offset: offset)
    }

    func offset(x: Double = 0, y: Double = 0, z: Double = 0) -> some RealityContent {
        RealityOffset(content: self, offset: .init(x: x, y: y, z: z))
    }

    // MARK: - aspectRatio

    func aspectRatio(
        _ ratio: Size3D? = nil,
        maxScale: Double? = nil,
        contentMode: ContentMode = .fit
    ) -> some RealityContent {
        RealityAspectRatio(content: self, aspectRatio: ratio, maxScale: maxScale, contentMode: contentMode)
    }

    func scaledToFit() -> some RealityContent { aspectRatio(maxScale: 1) }

    // MARK: - environment

    func environment<V>(_ keyPath: WritableKeyPath<RealityEnvironment, V>, _ value: V) -> some RealityContent {
        RealityEnvironmentModifier(self, keyPath, value)
    }
}

public enum ContentMode {
    case fit // , fill
}
