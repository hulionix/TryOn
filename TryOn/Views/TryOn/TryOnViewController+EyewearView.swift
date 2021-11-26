//
//  TryOnViewController+EyewearModelView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation
import CoreGraphics

extension TryOnViewController: EyewearView {
    
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
    
    /// Close snapshot image viewer
    func takeSnapshot() {
        let image = self.tryOnView.snapshot()
        self.overlayViewController.overlayView.screenshotView.show(image: image)
        
    }
    
    func closeImageViewer() {
        self.overlayViewController.overlayView.screenshotView.hideImage()
    }
    
    /// Hide loading progress view
    func hideProgressView() {
        self.overlayViewController.overlayView.progressView.hide()
    }
    
    /// Share current snapshot image
    func shareImage() {
        guard
            let image = self.overlayViewController.overlayView.screenshotView.imageView.image
        else { return }
        
        self.overlayViewController.presentShareDialogue(image: image)
    }
    
    /// Dismiss tutorial
    func dismissTutorial() {
        self.overlayViewController.overlayView.tutorialView.hide()
    }
    
    /// Request an eyewear model
    func requestEyewearModel() {
        self.getEyewearModel.get()
    }
}
