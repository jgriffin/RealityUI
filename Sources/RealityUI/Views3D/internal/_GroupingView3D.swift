//
// Created by John Griffin on 4/28/24
//

import Foundation

protocol _GroupingView3D {
    var contents: [any View3D] { get }
}

extension _GroupingView3D {
    var contentsCount: Int { contents.count }
}

func groupFlattened(_ content: some View3D) -> [any View3D] {
    guard let group = content as? _GroupingView3D else {
        return [content]
    }
    return group.contents.flatMap { groupFlattened($0) }
}
