//
//  EyewearModelView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation
import CoreGraphics

/// Protocol representing a view responsible for displaying the eyewear model
protocol EyewearModelView: AnyObject {
    
    func show(eyewearViewModel: EyewearViewModel)
    
    func show(loadingProgress: CGFloat)
    
    func show(error: String)
}
