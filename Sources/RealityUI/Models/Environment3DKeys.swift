//
// Created by John Griffin on 4/5/24
//

import Spatial

public extension Environment3D {
    var foregroundMaterial: RealityUIMaterial {
        get { self[RealityForegroundMaterialKey.self] }
        set { self[RealityForegroundMaterialKey.self] = newValue }
    }

    var lineRadius: Double {
        get { self[RealityLineRadiusKey.self] }
        set { self[RealityLineRadiusKey.self] = newValue }
    }
}

// MARK: - environment keys

enum RealityForegroundMaterialKey: Environment3DKey {
    static var defaultValue: RealityUIMaterial = .color(.blue)
}

enum RealityLineRadiusKey: Environment3DKey {
    static var defaultValue: Double = 0.001
}
