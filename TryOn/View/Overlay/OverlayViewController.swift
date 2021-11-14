//
//  OverlayViewController.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import UIKit

class OverlayViewController: UIViewController {
    
    var overlayView: OverlayView!
    
    init() {
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let overlayView = OverlayView()
        self.view = overlayView
        self.overlayView = overlayView
    }
}
