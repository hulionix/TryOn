//
//  EyewearModelView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation

/// Protocol representing a view responsible for displaying the eyewear model
protocol EyewearModelView: AnyObject {
    
    func show(eyewearModel: EyewearModel)
    
    func show(loadingProgress: Double)
    
    func show(error: String)
}
