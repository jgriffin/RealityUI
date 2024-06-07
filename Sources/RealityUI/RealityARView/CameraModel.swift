//
// Created by John Griffin on 6/3/24
//

import RealityKit
import simd
import Spatial
import SwiftUI

#if !os(visionOS)

    struct CameraModel {
        var lookAtPoint: Point3D = .zero
        var direction: Vector3D = .init(x: 0, y: 0, z: 3)
        var radius: Double = 3
    }

    class CameraHolder {
        var cameraModel: CameraModel = .init() {
            didSet { updateScene() }
        }

        private lazy var arView: ARView? = nil
        private let worldAnchor = AnchorEntity(world: .zero)
        private let lookAtEntity = Entity()
        private let perpectiveCamera = PerspectiveCamera()

        init(
            _ cameraModel: CameraModel = .init()
        ) {
            self.cameraModel = cameraModel
            perpectiveCamera.camera.fieldOfViewInDegrees = 60
        }

        func addToScene(_ scene: RealityKit.Scene, _ arView: ARView) {
            self.arView = arView
            scene.addAnchor(worldAnchor)
            worldAnchor.addChild(lookAtEntity)
            lookAtEntity.addChild(perpectiveCamera)

            updateScene()
        }

        func updateScene() {
            lookAtEntity.position = .init(cameraModel.lookAtPoint.vector)
            perpectiveCamera.position = .init(cameraModel.direction.vector * cameraModel.radius)
            perpectiveCamera.look(
                at: lookAtEntity.position(relativeTo: nil),
                from: perpectiveCamera.position(relativeTo: nil),
                relativeTo: nil
            )
        }
    }

    extension CameraHolder {
        /// normalized  0 ... 1
        func ratioPoint(_ point: CGPoint) -> CGPoint {
            guard let viewSize = arView?.bounds.size else { return .zero }

            return CGPoint(
                x: point.x / viewSize.width,
                y: 1 - point.y / viewSize.height
            )
        }

        /// normalized device coordinates: -1 ... 1
        func ndcPoint(ratioPoint: CGPoint) -> Vector3D {
            var ndc = Vector3D(
                x: 2 * ratioPoint.x - 1,
                y: 2 * ratioPoint.y - 1,
                z: 0.001
            )
            if (ndc.x * ndc.x + ndc.y * ndc.y) <= 1 {
                ndc.z = sqrt(max(0.001, 1 - ndc.length))
            }
            return ndc.normalized
        }

        func lookPoint(_ point: CGPoint) -> Vector3D? {
            guard let arView else { return nil }
            let plane = Vector3D.up.rotation(to: cameraModel.direction)
            let projection = ProjectiveTransform3D(rotation: plane)

            #if os(macOS)
                let point = CGPoint(x: point.x, y: arView.bounds.height - point.y)
            #endif

            guard let point = arView.unproject(
                point,
                ontoPlane: .init(projection),
                relativeToCamera: false
            ) else {
                return nil
            }

            return Vector3D(vector: .init(point))
        }
    }

#endif
