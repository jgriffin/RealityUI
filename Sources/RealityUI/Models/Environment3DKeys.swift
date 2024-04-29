//
// Created by John Griffin on 4/5/24
//

import Spatial

public extension Environment3DValues {
    var foregroundMaterial: RealityUIMaterial {
        get { self[RealityForegroundMaterialKey.self] }
        set { self[RealityForegroundMaterialKey.self] = newValue }
    }
}

// MARK: - environment keys

enum RealityForegroundMaterialKey: Environment3DKey {
    static var defaultValue: RealityUIMaterial = .color(.blue)
}
