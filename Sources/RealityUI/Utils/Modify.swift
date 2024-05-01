//
// Created by John Griffin on 4/18/24
//

import Foundation

func modify<T>(_ t: T, with: (inout T) -> Void) -> T {
    var copy = t
    with(&copy)
    return copy
}
