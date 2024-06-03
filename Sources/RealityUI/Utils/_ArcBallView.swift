//
// Created by John Griffin on 6/2/24
//

import simd
import SwiftUI

struct _ArcBallView: View {
    let getCameraPosition: () -> SIMD3<Float>
    let setCameraPosition: (SIMD3<Float>) -> Void

    @State var windowSize: CGSize?
    @GestureState private var originalCameraPostion: SIMD3<Float>?
    @GestureState private var originalRadius: Float?

    var body: some View {
        Color.clear
            .overlay(
                GeometryReader { proxy in
                    Color.clear.preference(key: ViewSizeKey.self, value: proxy.size)
                }
            )
            .onPreferenceChange(ViewSizeKey.self) { value in windowSize = value }
            .coordinateSpace(.named("ArcBallView"))
            .contentShape(Rectangle())
            .simultaneousGesture(cameraDragGesture(windowSize: windowSize))
            .simultaneousGesture(cameraZoomGesture)
    }

    func cameraDragGesture(windowSize _: CGSize?) -> some Gesture {
        DragGesture(coordinateSpace: .named("ARView"))
            .updating($originalCameraPostion) { value, state, _ in
                guard let windowSize else { return }

                guard let cameraPosition = state else {
                    state = getCameraPosition()
                    return
                }

                let startNdc = ndc(value.startLocation, windowSize: windowSize)
                let locationNdc = ndc(value.location, windowSize: windowSize)

                let start = zNdc(startNdc)
                let location = zNdc(locationNdc)
                let quat = simd_quatf(from: start, to: location).normalized.inverse

                let newPosition = simd_act(quat, cameraPosition)
                setCameraPosition(newPosition)
            }
    }

    var cameraZoomGesture: some Gesture {
        MagnifyGesture()
            .updating($originalRadius) { value, state, _ in
                guard let radius = state else {
                    state = length(getCameraPosition())
                    return
                }

                let cameraPosition = getCameraPosition()
                let newPosition = normalize(cameraPosition) * radius * .init(value.magnification)
                setCameraPosition(newPosition)
            }
    }

    // normalized device coordinates
    func ndc(_ point: CGPoint, windowSize: CGSize) -> CGPoint {
        .init(x: 2 * point.x / windowSize.width - 1,
              y: 2 * (1 - point.y / windowSize.height) - 1)
    }

    // ndc + a z-coordinate
    func zNdc(_ ndcPoint: CGPoint) -> SIMD3<Float> {
        let x2py2 = ndcPoint.x * ndcPoint.x + ndcPoint.y * ndcPoint.y
        let z = x2py2 > 1 ? 0 : sqrt(abs(1 - x2py2))
        return [.init(ndcPoint.x), .init(ndcPoint.y), .init(z)]
    }

    struct ViewSizeKey: PreferenceKey {
        static let defaultValue: CGSize? = nil
        static func reduce(value: inout CGSize?, nextValue: () -> CGSize?) {
            value = value ?? nextValue()
        }
    }
}
