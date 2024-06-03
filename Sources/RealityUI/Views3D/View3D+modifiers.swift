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
        _Frame3D(
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
        frame(width: size.width, height: size.height, depth: size.depth, alignment: alignment)
    }

    func frame(
        size: Double,
        alignment: Alignment3D = .center
    ) -> some View3D {
        frame(size: .one * size, alignment: alignment)
    }

    // MARK: - overlay

    func overlay(alignment: Alignment3D = .center, @View3DBuilder _ content: () -> some View3D) -> some View3D {
        _Overlay3D(self, overlay: content(), alignment: alignment)
    }

    func border() -> some View3D {
        overlay { _BorderBox3D() }
    }

    // MARK: - padding

    func padding(_ insets: EdgeInsets3D) -> some View3D {
        _Padding3D(content: self, edgeInsets: insets)
    }

    @inlinable func padding(_ all: Double) -> some View3D {
        padding(.init(all: all))
    }

    // MARK: - offset

    func offset(_ offset: Vector3D) -> some View3D {
        _Offset3D(content: self, offset: offset)
    }

    func offset(x: Double = 0, y: Double = 0, z: Double = 0) -> some View3D {
        offset(.init(x: x, y: y, z: z))
    }

    func aligned(_ alignment: Alignment3D) -> some View3D {
        _Aligned3D(self, alignment)
    }

    // MARK: - pose

    func pose(_ pose: Pose3D) -> some View3D {
        _Pose3D(content: self, pose: pose)
    }

    @inlinable func position(_ position: Point3D) -> some View3D {
        pose(.init(position: position, rotation: .identity))
    }

    @inlinable func rotation(_ rotation: Rotation3D) -> some View3D {
        pose(.init(position: .zero, rotation: rotation))
    }

    @inlinable func rotation(from: Vector3D, to: Vector3D) -> some View3D {
        rotation(from.rotation(to: to))
    }

    @inlinable func rotation(angle: Angle2D, axis: RotationAxis3D) -> some View3D {
        rotation(.init(angle: angle, axis: axis))
    }

    @inlinable func rotation(
        position: Point3D = Point3D(x: 0, y: 0, z: 0),
        target: Point3D,
        up: Vector3D = Vector3D(x: 0, y: 1, z: 0)
    ) -> some View3D {
        rotation(.init(position: position, target: target, up: up))
    }

    // MARK: - aspectRatio

    func aspectRatio(
        _ ratio: Size3D? = nil,
        maxScale: Double? = nil,
        contentMode: ContentMode = .fit
    ) -> some View3D {
        _AspectRatio3D(content: self, aspectRatio: ratio, maxScale: maxScale, contentMode: contentMode)
    }

    @inlinable func scaledToFit() -> some View3D { aspectRatio(maxScale: 1) }

    // MARK: - scale

    func scale(_ scale: Size3D) -> some View3D {
        _Scale3D(content: self, scale: scale)
    }

    @inlinable func scale(by scale: Double) -> some View3D {
        self.scale(.one * scale)
    }

    // MARK: - ID

    func id(_ id: some Hashable) -> some View3D {
        _ID3D(self, id)
    }

    // MARK: - environment

    func environment<V>(_ keyPath: WritableKeyPath<Environment3D, V>, _ value: V) -> some View3D {
        _Environment3D(self, keyPath, value)
    }

    @inlinable func foreground(_ material: Material3D) -> some View3D {
        environment(\.foregroundMaterial, material)
    }

    @inlinable func lineRadius(_ radius: Double) -> some View3D {
        environment(\.lineRadius, radius)
    }
}

public enum ContentMode {
    case fit, fill
}
