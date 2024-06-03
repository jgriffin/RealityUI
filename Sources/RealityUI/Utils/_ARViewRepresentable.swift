//
// Created by John Griffin on 6/1/24
//

import RealityKit
import SwiftUI

#if !os(visionOS)

    #if os(iOS)
        import UIKit

        typealias PlatformViewRepresentable = UIViewRepresentable
    #elseif os(macOS)
        import AppKit

        typealias PlatformViewRepresentable = NSViewRepresentable
    #endif

    struct _ARViewRepresentable: PlatformViewRepresentable {
        let arView: ARView
        let setupScene: (RealityKit.Scene) -> Void
        let update: (ARView) -> Void

        #if os(iOS)

            func makeUIView(context _: Context) -> ARView {
                setupScene(arView.scene)
                return arView
            }

            func updateUIView(_ view: ARView, context _: Context) {
                update(view)
            }

        #elseif os(macOS)

            func makeNSView(context _: Context) -> ARView {
                setupScene(arView.scene)
                return arView
            }

            func updateNSView(_ view: ARView, context _: Context) {
                update(view)
            }

        #endif

        // MARK: - coordinator

        func makeCoordinator() -> ARViewCoordinator {
            ARViewCoordinator(self)
        }

        class ARViewCoordinator {
            public var representable: _ARViewRepresentable

            public init(_ representableContainer: _ARViewRepresentable) {
                representable = representableContainer
            }
        }
    }

#endif
