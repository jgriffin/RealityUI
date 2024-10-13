//
// Created by John Griffin on 4/5/24
//

import Spatial

public extension Environment3D {
    var foregroundMaterial: Material3D {
        get { self[ForegroundMaterialKey.self] }
        set { self[ForegroundMaterialKey.self] = newValue }
    }

    var lineRadius: Double {
        get { self[LineRadiusKey.self] }
        set { self[LineRadiusKey.self] = newValue }
    }
}

// MARK: - Environment3DKeys

enum ForegroundMaterialKey: Environment3DKey {
    static let defaultValue: Material3D = .color(.blue)
}

enum LineRadiusKey: Environment3DKey {
    static let defaultValue: Double = 0.001
}
