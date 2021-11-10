//
//  ViewController.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import UIKit
import ARKit

class TryOnViewController: UIViewController, ARSessionDelegate {
    
    var tryOnView: TryOnView!
    
    /// Load the AppView
    override func loadView() {
        let view = TryOnView()
        self.view = view
        self.tryOnView = view
        view.backgroundColor = .blue
        ARSessionDelegate
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setSession()
    }
    
    func setSession() {
        guard ARFaceTrackingConfiguration.isSupported else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        tryOnView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

