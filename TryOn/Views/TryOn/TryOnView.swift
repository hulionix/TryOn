//
//  TryOnView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import Foundation
import ARKit
import SceneKit

class TryOnView: ARSCNView, ARSCNViewDelegate {
    let tryOnScene: TryOnScene
    
    init() {
        self.tryOnScene = TryOnScene()
        super.init(frame: .zero, options: nil)
        self.scene = self.tryOnScene
        self.automaticallyUpdatesLighting = true
        self.delegate = self.tryOnScene
        
        let pinchRecognizer = UIPinchGestureRecognizer(target: self,
                                                       action: #selector(handleScaling))
        self.addGestureRecognizer(pinchRecognizer)
        
        let panRecognizer = UIPanGestureRecognizer(target: self,
                                                   action: #selector(handlePositioning))
        self.addGestureRecognizer(panRecognizer)
    }
    
    /// Handle scaling eyewear
    @objc func handleScaling(gesture: UIPinchGestureRecognizer) {
        if let eyewear = self.tryOnScene.eyewearNode {
            if gesture.state == .changed {
                // Map gesture scale range 0-2 to 0.8-1.2
                let relativeScale = 0.8 + ((gesture.scale - 0) * (1.2 - 0.8) / (2 - 0))
                let scale = self.tryOnScene.userScale * Float(relativeScale)
                eyewear.scale = SCNVector3(scale, scale, scale)
            } else if gesture.state == .began {
                self.tryOnScene.userScale = eyewear.scale.x
            }
        }
    }
    
    /// Handle positioning eyewear
    @objc func handlePositioning(gesture: UIPanGestureRecognizer) {
        if let camera = self.pointOfView,
            let face = self.tryOnScene.faceMaskNode,
            let eyewear = self.tryOnScene.eyewearNode {
            if gesture.state == .changed {
                // Front face vector in camera coord space
                let vec = face.convertVector(SCNVector3(0,0,-1), to: camera)
                let translation = gesture.translation(in: self)
                // Take x projection of vec with 0-1 of x translation in view as driver for eyewear depth
                let translateZ = vec.x * Float(translation.x / UIScreen.main.bounds.width)
                // Take 0-1 of y translation in view as driver for eyewear level
                let translateY = Float(translation.y / UIScreen.main.bounds.height)
                
                eyewear.position.z = self.tryOnScene.userFront - translateZ
                eyewear.position.y = self.tryOnScene.userUp - translateY
            } else if gesture.state == .began {
                self.tryOnScene.userFront = eyewear.position.z
                self.tryOnScene.userUp = eyewear.position.y
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
