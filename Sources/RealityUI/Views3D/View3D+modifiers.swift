//
// Created by John Griffin on 4/18/24
//

import Spatial

public extension View3D {
    // MARK: - frame

    func frame(
        width: Double? = nil,
        height: Double? = nil,
        depth: Double? = nil,
        alignment: Alignment3D = .center
    ) -> some View3D {
        _FrameView3D(
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
    ) -> some View3D {
        _FrameView3D(
            content: self,
            width: size.width,
            height: size.height,
            depth: size.depth,
            alignment: alignment
        )
    }

    // MARK: - padding

    func padding(_ insets: EdgeInsets3D) -> some View3D {
        _PaddingView3D(content: self, edgeInsets: insets)
    }

    func padding(_ all: Double) -> some View3D {
        _PaddingView3D(content: self, edgeInsets: .init(all: all))
    }

    // MARK: - offset

    func offset(_ offset: Vector3D) -> some View3D {
        _OffsetView3D(content: self, offset: offset)
    }

    func offset(x: Double = 0, y: Double = 0, z: Double = 0) -> some View3D {
        _OffsetView3D(content: self, offset: .init(x: x, y: y, z: z))
    }

    // MARK: - aspectRatio

    func aspectRatio(
        _ ratio: Size3D? = nil,
        maxScale: Double? = nil,
        contentMode: ContentMode = .fit
    ) -> some View3D {
        _AspectRatioView3D(content: self, aspectRatio: ratio, maxScale: maxScale, contentMode: contentMode)
    }

    func scaledToFit() -> some View3D { aspectRatio(maxScale: 1) }

    // MARK: - environment

    func environment<V>(_ keyPath: WritableKeyPath<Environment3DValues, V>, _ value: V) -> some View3D {
        _EnvironmentModifierView3D(self, keyPath, value)
    }
}

public enum ContentMode {
    case fit // , fill
}
