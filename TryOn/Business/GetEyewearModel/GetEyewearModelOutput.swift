//
//  GetEyewearModelOutput.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation

/// Protocol representing the output of getting an eyewear model
protocol GetEyewearModelOutput {
    
    /// Called when an eyewear model is ready
    func present(eyewearModel: EyewearModel)
    
    /// Called to update loading progress
    func update(progress: RequestProgress)
    
    /// Called when requesting an eyewear model fails
    func failedWith(error: RequestError)
}
