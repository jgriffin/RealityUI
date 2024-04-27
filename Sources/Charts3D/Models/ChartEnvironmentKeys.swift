//
// Created by John Griffin on 4/5/24
//

import RealityUI
import Spatial

public extension ChartEnvironment {
    var foregroundMaterial: RealityMaterial {
        get { self[ChartForegroundMaterialKey.self] }
        set { self[ChartForegroundMaterialKey.self] = newValue }
    }

    var symbolShape: any RealityShapeStyle {
        get { self[ChartSymbolShapeKey.self] }
        set { self[ChartSymbolShapeKey.self] = newValue }
    }

    var symbolSize: Size3D {
        get { self[ChartSymbolSizeKey.self] }
        set { self[ChartSymbolSizeKey.self] = newValue }
    }

    var lineMaterial: RealityMaterial {
        get { self[ChartLineMaterialKey.self] }
        set { self[ChartLineMaterialKey.self] = newValue }
    }
}

// MARK: - environment keys

enum ChartForegroundMaterialKey: ChartEnvironmentKey {
    static var defaultValue: RealityMaterial = .color(.blue)
}

enum ChartSymbolShapeKey: ChartEnvironmentKey {
    static var defaultValue: any RealityShapeStyle = Box()
}

enum ChartSymbolSizeKey: ChartEnvironmentKey {
    static var defaultValue: Size3D = .one * 0.1
}

enum ChartLineMaterialKey: ChartEnvironmentKey {
    static var defaultValue: RealityMaterial = .color(.blue)
}
