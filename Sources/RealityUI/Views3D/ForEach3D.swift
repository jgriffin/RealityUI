//
// Created by John Griffin on 4/28/24
//

import RealityKit
import Spatial

public struct ForEach3D<Data: RandomAccessCollection, ID: Hashable, Content: View3D>: View3D, CustomView3D {
    public let data: Data
    public let id: KeyPath<Data.Element, ID>
    public let content: (Data.Element) -> Content

    public init(
        _ data: Data,
        id: KeyPath<Data.Element, ID>,
        @View3DBuilder content: @escaping (Data.Element) -> Content
    ) {
        self.data = data
        self.id = id
        self.content = content
    }

    public init<Element: Identifiable>(
        _ data: Data,
        @View3DBuilder content: @escaping (Data.Element) -> Content
    ) where Data.Element == Element, Element.ID == ID {
        self.data = data
        id = \Element.id
        self.content = content
    }

    // MARK: - _GroupingView3D

    var contents: [any View3D] {
        data.map { element in
            content(element)
                .id(element[keyPath: id])
        }
    }

    // MARK: - CustomRealityContent

    public func customSizeFor(_ proposed: ProposedSize3D, _ env: Environment3D) -> Size3D {
        Stack3D(alignment: .center) {
            self
        }.sizeThatFits(proposed, env)
    }

    public func customRenderWithSize(_ size: Size3D, _ env: Environment3D) -> Entity {
        Stack3D(alignment: .center) {
            self
        }.renderWithSize(size, env)
    }
}

extension ForEach3D: _GroupingView3D {}
