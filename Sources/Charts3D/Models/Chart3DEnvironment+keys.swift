//
// Created by John Griffin on 4/5/24
//

import RealityUI
import Spatial

public extension Chart3DEnvironment {
    var foregroundMaterial: Material3D {
        get { self[ChartForegroundMaterialKey.self] }
        set { self[ChartForegroundMaterialKey.self] = newValue }
    }

    var symbolShape: any Shape3DStyle {
        get { self[ChartSymbolShapeKey.self] }
        set { self[ChartSymbolShapeKey.self] = newValue }
    }

    var symbolSize: Size3D {
        get { self[ChartSymbolSizeKey.self] }
        set { self[ChartSymbolSizeKey.self] = newValue }
    }

    var lineMaterial: Material3D {
        get { self[ChartLineMaterialKey.self] }
        set { self[ChartLineMaterialKey.self] = newValue }
    }
}

// MARK: - environment keys

enum ChartForegroundMaterialKey: ChartEnvironmentKey {
    static let defaultValue: Material3D = .blue100
}

enum ChartSymbolShapeKey: ChartEnvironmentKey {
    static let defaultValue: any Shape3DStyle = Box3D()
}

enum ChartSymbolSizeKey: ChartEnvironmentKey {
    static let defaultValue: Size3D = .one * 0.1
}

enum ChartLineMaterialKey: ChartEnvironmentKey {
    static let defaultValue: Material3D = .blue100
}
