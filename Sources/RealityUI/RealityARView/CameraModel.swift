//
// Created by John Griffin on 6/3/24
//

import RealityKit
import simd
import Spatial

#if !os(visionOS)

    struct CameraModel {
        var lookAtPoint: Point3D = .zero
        var direction: Vector3D = .init(x: -1, y: 1, z: 3)
        var radius: Double = 3
    }

    class CameraHolder {
        var cameraModel: CameraModel = .init() {
            didSet { updateScene() }
        }

        private let worldAnchor = AnchorEntity(world: .zero)
        private let lookAtEntity = Entity()
        private let perpectiveCamera = PerspectiveCamera()

        init(
            _ cameraModel: CameraModel = .init()
        ) {
            self.cameraModel = cameraModel
            perpectiveCamera.camera.fieldOfViewInDegrees = 60
        }

        func addToScene(_ scene: RealityKit.Scene) {
            scene.addAnchor(worldAnchor)
            worldAnchor.addChild(lookAtEntity)
            lookAtEntity.addChild(perpectiveCamera)

            updateScene()
        }

        func updateScene() {
            lookAtEntity.position = .init(cameraModel.lookAtPoint.vector)
            perpectiveCamera.position = .init(cameraModel.direction.vector * cameraModel.radius)
            perpectiveCamera.look(
                at: .zero,
                from: perpectiveCamera.position,
                relativeTo: lookAtEntity
            )
        }
    }

#endif
