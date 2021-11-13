//
//  TryOnViewController+EyewearModelView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation

extension TryOnViewController: EyewearModelView {
    
    /// Show an eyewear model
    func show(eyewearModel: EyewearModel) {
        print(eyewearModel)
    }
    
    /// Show loading progress
    func show(loadingProgress: Double) {
        print(loadingProgress)
    }
    
    /// Show an error
    func show(error: String) {
        print(error)
    }
}
