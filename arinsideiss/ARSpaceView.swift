//
//  ARSpaceView.swift
//  arinsideiss
//
//  Created by Yasuhito NAGATOMO on 2022/01/22.
//

import SwiftUI
import RealityKit
import ARKit

struct ARSpaceView: UIViewRepresentable {
    let modelName = "InsideISS.usdz"
    let modelPosition = SIMD3<Float>([0, 0, 0]) // [meters]

    func makeUIView(context: Context) -> some UIView {
        let arView = ARView(frame: .zero)

        let anchorEntity = AnchorEntity(world: modelPosition)
        arView.scene.addAnchor(anchorEntity)

        do {
            let modelEntity = try Entity.load(named: modelName)
            anchorEntity.addChild(modelEntity)
        } catch {
            assertionFailure("could not load assets.")
        }

        let config = ARWorldTrackingConfiguration()
        if ARWorldTrackingConfiguration.supportsFrameSemantics(.personSegmentationWithDepth) {
            print("DEBUG: personSegmentationWithDepth is supported.")
            config.frameSemantics.insert(.personSegmentationWithDepth)
        } else {
            print("DEBUG: personSegmentationWithDepth is not supported.")
        }
        arView.session.run(config)

        return arView
    }

    func updateUIView(_ uiView: UIViewType, context: Context) {
    }
}
