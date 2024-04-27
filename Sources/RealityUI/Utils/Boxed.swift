//
// Created by John Griffin on 4/19/24
//

import Foundation

@propertyWrapper
public final class Boxed<T> {
    public var wrappedValue: T

    public init(wrappedValue: T) {
        self.wrappedValue = wrappedValue
    }
}
