//
//  ViewController.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import UIKit
import ARKit

class TryOnViewController: UIViewController {
    
    /// Load the AppView
    override func loadView() {
        let view = TryOnView()
        self.view = view
        view.backgroundColor = .blue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        setSession()
    }
    
    func setSession() {
        guard ARFaceTrackingConfiguration.isSupported , let view = self.view as? ARSCNView else { return }
        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        view.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
    }
}

