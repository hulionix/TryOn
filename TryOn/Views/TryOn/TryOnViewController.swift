//
//  ViewController.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import UIKit
import ARKit
import SnapKit

class TryOnViewController: UIViewController {
    
    /// TryOn view
    var tryOnView: TryOnView!
    
    /// Use case for getting an eyewear model
    let getEyewearModel: GetEyewearModel
    
    /// View controller containing UI elements
    let overlayViewController: OverlayViewController
    
    init(overlayViewController: OverlayViewController,
         getEyewearModel: GetEyewearModel) {
        self.overlayViewController = overlayViewController
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
        
        self.overlayViewController.willMove(toParent: self)
        self.addChild(self.overlayViewController)
        self.view.addSubview(self.overlayViewController.view)
        self.overlayViewController.didMove(toParent: self)
        
        self.overlayViewController.view.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self.tryOnView)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    /// Set session configuration and load the model
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        guard
            ARFaceTrackingConfiguration.isSupported
        else { return }

        let configuration = ARFaceTrackingConfiguration()
        configuration.isLightEstimationEnabled = true
        self.tryOnView.session.run(configuration, options: [.resetTracking, .removeExistingAnchors])
        
        self.getEyewearModel.get()
    }
}

