//
//  TryOnScene.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation
import ARKit
import SceneKit
import GLTFSceneKit

class TryOnScene: SCNScene, ARSCNViewDelegate {
    
    /// Eyewear parent node
    var eyewearParentNode: SCNNode
    
    /// Eyewear node
    var eyewearNode: SCNNode?
    
    /// Face occlusion nodes
    var faceMaskNode: SCNNode!
    
    override init() {
        self.eyewearParentNode = SCNNode()
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Get the node responsible for visualizing a face anchor
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard
            let sceneView = renderer as? ARSCNView,
                anchor is ARFaceAnchor
        else { return nil }

        let maskGeometry = ARSCNFaceGeometry(device: sceneView.device!)!
        maskGeometry.firstMaterial!.colorBufferWriteMask = []
        faceMaskNode = SCNNode(geometry: maskGeometry)
        //faceMaskNode.geometry?.subdivisionLevel = 2
        faceMaskNode.renderingOrder = -1
        
        self.eyewearParentNode.addChildNode(self.faceMaskNode)
        self.fitEyewearOnFace()
        return self.eyewearParentNode
    }
    
    /// Deform the face mask node
    func renderer(_ renderer: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard
            let faceMaskGeometry = self.faceMaskNode.geometry as? ARSCNFaceGeometry,
            let faceAnchor = anchor as? ARFaceAnchor
        else { return }
        
        faceMaskGeometry.update(from: faceAnchor.geometry)
    }
    
    /// Install the eyewear model on face
    func updateWith(eyewearViewsModel model: EyewearViewModel) {
        do {
            let eyewearNode = try GLTFSceneSource(url: model.url).scene().rootNode.childNodes.first
            eyewearNode?.geometry?.firstMaterial!.lightingModel = .physicallyBased
            eyewearNode?.castsShadow = true
            self.eyewearParentNode.addChildNode(eyewearNode!)
            self.eyewearNode = eyewearNode!
            self.fitEyewearOnFace()
        } catch {
            print("\(error.localizedDescription)")
        }
    }
    
    /// Fit the eyewear on face
    private func fitEyewearOnFace() {
        guard
            let eyewear = self.eyewearNode,
            let face = self.faceMaskNode
        else { return }
        
        let eMin = eyewear.boundingBox.min
        let eMax = eyewear.boundingBox.max
        
        let fMin = face.boundingBox.min
        let fMax = face.boundingBox.max
        
        let scale = ((fMax.x - fMin.x) / (eMax.x - eMin.x)) * UIConfig.eyewearScaleFactor
        eyewear.scale = SCNVector3(scale, scale, scale)
        eyewear.position.z = fMax.z + UIConfig.eyewearZShift
        eyewear.position.y += UIConfig.eyewearYShift
    }
}
