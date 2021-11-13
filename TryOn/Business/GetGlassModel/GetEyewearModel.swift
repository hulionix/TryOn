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
    
    init(requester: EyewearModelRequester) {
        self.requester = requester
        self.requester.delegate = self
    }
    
    /// Request a model
    func get() {
        self.requester.requestModel(named: AppConfig.demoFileName)
    }
    
    /// Called when the requested model becomes available
    func requester(didReceiveEyewearModel model: EyewearModel) {
        
    }
    
    /// Called with a value indicating request loading progress
    func requester(didReceiveProgress progress: RequestProgress) {
        print(progress.value)
    }
    
    /// Called whenever the request produces an error
    func requester(failedWithError error: RequestError) {
        
    }
}
