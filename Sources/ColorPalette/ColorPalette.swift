//
// Created by John Griffin on 4/30/24
//

#if canImport(UIKit)
    import UIKit
#elseif canImport(AppKit)
    import AppKit
#endif

import SwiftUI

public struct ColorPalette {
    public let name: String
    public let type: PaletteType
    public let uiColors: [PlatformColor]

    public enum PaletteType {
        case categorical, sequential, divergent
    }

    public init(_ name: String, _ type: PaletteType, uiColors: [PlatformColor]) {
        self.name = name
        self.type = type
        self.uiColors = uiColors
    }

    public init(_ name: String, _ type: PaletteType, hexColors: [String]) {
        self.init(name, type, uiColors: hexColors.map { PlatformColor(hex: $0) })
    }

    public init(_ name: String, _ type: PaletteType, _ hexColors: String...) {
        self.init(name, type, uiColors: hexColors.map { PlatformColor(hex: $0) })
    }
}
