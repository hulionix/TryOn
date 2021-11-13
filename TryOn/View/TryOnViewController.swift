//
//  ViewController.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import UIKit
import ARKit

class TryOnViewController: UIViewController {
    
    var tryOnView: TryOnView!
    
    let getEyewearModel: GetEyewearModel
    
    init(getEyewearModel: GetEyewearModel) {
        self.getEyewearModel = getEyewearModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Load the AppView
    override func loadView() {
        let view = TryOnView()
        self.view = view
        self.tryOnView = view
        view.backgroundColor = .blue
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        getEyewearModel.get()
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

