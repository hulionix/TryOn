//
//  TryOnViewController+EyewearModelView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation
import CoreGraphics

extension TryOnViewController: EyewearModelView {
    
    /// Show an eyewear model
    func show(eyewearViewModel: EyewearViewModel) {
        self.tryOnView.tryOnScene.updateWith(eyewearViewsModel: eyewearViewModel)
    }
    
    /// Show loading progress
    func show(loadingProgress: CGFloat) {
        self.overlayViewController.overlayView.progressView.progress = loadingProgress
    }
    
    /// Show an error
    func show(error: String) {
        print(error)
    }
}
