//
//  EyewearModelView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation
import CoreGraphics

/// Protocol representing a view responsible for displaying the eyewear model
protocol EyewearView: AnyObject {
    
    /// Show an eyewear model
    func show(eyewearViewModel: EyewearViewModel)
    
    /// Show loading progress
    func show(loadingProgress: CGFloat)
    
    /// Show an error
    func show(error: String)
    
    /// Take a snapshop
    func takeSnapshot()
    
    /// Close snapshot image viewer
    func closeImageViewer()
    
    /// Hide loading progress view
    func hideProgressView()
    
    /// Share current snapshot image
    func shareImage()
}
