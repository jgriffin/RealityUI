//
// Created by John Griffin on 4/4/24
//

import RealityKit

public protocol Materializable {
    func makeMaterial() -> RealityKit.Material
}

public enum Material3D: Materializable {
    case simple(color: SimpleMaterial.Color, roughness: Float, isMetalic: Bool)

    // MARK: - materializable

    public func makeMaterial() -> any Material {
        switch self {
        case let .simple(color: color, roughness: roughness, isMetalic: isMetalic):
            SimpleMaterial(color: color, roughness: .float(roughness), isMetallic: isMetalic)
        }
    }
}

public extension Material3D {
    static func color(
        _ color: SimpleMaterial.Color,
        alpha: Double? = nil,
        roughness: Float = 1,
        isMetalic: Bool = false
    ) -> Material3D {
        .simple(
            color: alpha.flatMap { color.withAlphaComponent($0) } ?? color,
            roughness: roughness,
            isMetalic: isMetalic
        )
    }

    static let blue100: Material3D = .color(.blue)
    static let blue80: Material3D = .color(.blue, alpha: 0.8)
    static let blue20: Material3D = .color(.blue, alpha: 0.2)
    static let cyan20: Material3D = .color(.cyan, alpha: 0.2)
    static let cyan60: Material3D = .color(.cyan, alpha: 0.6)
}
