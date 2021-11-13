//
//  EyewearModelRequester.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import Foundation

/// Protocol representing an object responsible for requesting a Eyewear model
protocol EyewearModelRequester {
    
    /// A delegate object responsible for handling the results of an eyewear model request
    var delegate: EyewearModelRequesterDelegate? { get set }
    
    /// Requests an eyewear Model
    func requestModel(named: String)
}

/// A data structure representing request progress
struct RequestProgress {
    
    /// Progress value between 0-1
    let value: Double
    
    init(_ value: Double) {
        self.value = value
    }
}

/// A data structure representing the result of a requested file
struct RequestedFile {
    
    /// The requested file name
    let fileName: String
    
    /// The requested file extension
    let fileExtension: String
    
    /// The requested file path on disk
    let url: URL
}

/// Possible errors that can arise from requesting a model
enum RequestError: Error {
    case networkLoadProblem, couldNotProcess
}

/// Protocol representing an object that can handle model requesting results
protocol EyewearModelRequesterDelegate: AnyObject {
    
    /// Called when the requested model becomes available
    func requester(didReceiveEyewearModel: EyewearModel)
    
    /// Called with a value indicating request loading progress
    func requester(didReceiveProgress: RequestProgress)
    
    /// Called whenever the request produces an error
    func requester(failedWithError: RequestError)
}
