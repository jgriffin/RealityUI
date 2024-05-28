//
// Created by John Griffin on 5/28/24
//

import Foundation
import SwiftUI

#if canImport(UIKit)

    import UIKit

    public typealias PlatformColor = UIColor

#elseif canImport(AppKit)

    import AppKit

    public typealias PlatformColor = NSColor

    public extension Color {
        init(uiColor: PlatformColor) {
            self.init(nsColor: uiColor)
        }
    }

#endif
