//
// Created by John Griffin on 4/21/24
//

import Charts
import Foundation

// MARK: - Plottable Value

public struct PlottableValue<Value: Plottable> {
    public let label: String
    public let value: Value

    private init(_ label: some StringProtocol, _ value: Value) {
        self.label = .init(label)
        self.value = value
    }

    public static func value(_ label: some StringProtocol, _ value: Value) -> Self {
        Self(label, value)
    }
}
