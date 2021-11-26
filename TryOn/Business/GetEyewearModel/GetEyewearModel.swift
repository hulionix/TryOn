//
//  GetEyewearModel.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import Foundation

/// Use case for handling the fetching of an eyewear model through a requester.
class GetEyewearModel: EyewearModelRequesterDelegate {
    
    /// Requests the eyewear model
    private var requester: EyewearModelRequester
    
    private let output: GetEyewearModelOutput
    
    init(requester: EyewearModelRequester, output: GetEyewearModelOutput) {
        self.requester = requester
        self.output = output
        self.requester.delegate = self
    }
    
    /// Request a model
    func get() {
        self.requester.requestModel(named: AppConfig.demoFileName)
    }
    
    /// Called when the requested model becomes available
    func requester(didReceiveEyewearModel model: EyewearModel) {
        self.output.present(eyewearModel: model)
    }
    
    /// Called with a value indicating request loading progress
    func requester(didReceiveProgress progress: RequestProgress) {
        self.output.update(progress: progress)
    }
    
    /// Called whenever the request produces an error
    func requester(failedWithError error: RequestError) {
        self.output.failedWith(error: error)
    }
}
