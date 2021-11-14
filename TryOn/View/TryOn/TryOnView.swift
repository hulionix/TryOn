//
//  TryOnView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import Foundation
import ARKit
import SceneKit

class TryOnView: ARSCNView{
    let tryOnScene: TryOnScene
    
    init() {
        self.tryOnScene = TryOnScene()
        super.init(frame: .zero, options: nil)
        self.scene = self.tryOnScene
        self.automaticallyUpdatesLighting = true
        self.delegate = self.tryOnScene
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
