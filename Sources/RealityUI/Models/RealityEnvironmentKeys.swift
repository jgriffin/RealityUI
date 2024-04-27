//
// Created by John Griffin on 4/5/24
//

import Spatial

public extension RealityEnvironment {
    var foregroundMaterial: RealityMaterial {
        get { self[RealityForegroundMaterialKey.self] }
        set { self[RealityForegroundMaterialKey.self] = newValue }
    }
}

// MARK: - environment keys

enum RealityForegroundMaterialKey: RealityEnvironmentKey {
    static var defaultValue: RealityMaterial = .color(.blue)
}
