//
//  ViewController.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import UIKit
import ARKit

class TryOnViewController: UIViewController, ARSCNViewDelegate {
    
    /// TryOn view
    var tryOnView: TryOnView!
    
    /// Use case for getting an eyewear model
    let getEyewearModel: GetEyewearModel
    
    init(getEyewearModel: GetEyewearModel) {
        self.getEyewearModel = getEyewearModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Load the TryOnView
    override func loadView() {
        let view = TryOnView()
        self.view = view
        self.tryOnView = view
    }
    
    /// Set session configuration and load the model
    override func viewDidAppear(_ animated: Bool) {
        guard
            ARFaceTrackingConfiguration.isSupported
        else { return }

        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        self.tryOnView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        self.getEyewearModel.get()
        
        return
        
//        guard
//            ARWorldTrackingConfiguration.supportsUserFaceTracking
//        else { return }
//        
//        let configuration = ARWorldTrackingConfiguration()
//        configuration.isLightEstimationEnabled = true
//        configuration.environmentTexturing = .automatic
//        configuration.userFaceTrackingEnabled = true
//        configuration.wantsHDREnvironmentTextures = true
//        self.tryOnView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

