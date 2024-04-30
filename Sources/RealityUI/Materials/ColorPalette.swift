//
// Created by John Griffin on 4/30/24
//

import SwiftUI
import UIKit

public struct ColorPalette {
    public let name: String
    public let type: PaletteType
    public let uiColors: [UIColor]

    public enum PaletteType {
        case categorical, sequential, divergent
    }

    public init(_ name: String, _ type: PaletteType, uiColors: [UIColor]) {
        self.name = name
        self.type = type
        self.uiColors = uiColors
    }

    public init(_ name: String, _ type: PaletteType, hexColors: [String]) {
        self.init(name, type, uiColors: hexColors.map { UIColor(hex: $0) })
    }

    public init(_ name: String, _ type: PaletteType, _ hexColors: String...) {
        self.init(name, type, uiColors: hexColors.map { UIColor(hex: $0) })
    }
}
