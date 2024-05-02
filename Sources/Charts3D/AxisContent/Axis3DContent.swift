//
// Created by John Griffin on 4/30/24
//

import RealityUI

/// essentially Axis3DMarks
public protocol Axis3DContent {
    associatedtype View3DBody: View3D

    @View3DBuilder
    func renderView(_ proxy: DimensionProxy, env: Chart3DEnvironment) -> View3DBody
}
