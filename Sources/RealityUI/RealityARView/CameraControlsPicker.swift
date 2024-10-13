//
// Created by John Griffin on 6/2/24
//

import RealityKit
import SwiftUI

#if !os(visionOS)

    struct CameraControlsPicker: View {
        @Binding var cameraControls: CameraControls

        var body: some View {
            HStack {
                button(.none, "cursorarrow")
                button(.orbit, "rotate.3d")
                button(.dolly, "arrow.up.and.down.and.arrow.left.and.right")
            }
            .foregroundColor(.primary.opacity(0.8))
            .buttonStyle(.plain)
            .padding(5)
            .background(
                .regularMaterial,
                in: RoundedRectangle(cornerRadius: 5)
            )
        }

        func button(_ forMode: CameraControls, _ image: String) -> some View {
            Button(action: { cameraControls = forMode }) {
                Image(systemName: image)
                    .foregroundColor(cameraControls == forMode ? .blue : nil)
            }
        }
    }

#endif
