//
//  AFNetworkingAdapter.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import Foundation
import Combine

/// Data structure for representing a download request
struct FileDownloadRequest {
    
    /// Request URL
    let url: String
    
    /// File Name
    let fileName: String
    
    /// File extension
    let fileExtension: String
    
    /// Destination where the file should be saved
    let destination: FileManager.SearchPathDirectory
    
    /// If the downloaded file should override an existing one
    let overrideExisting: Bool
}

/// Protocol representing an object that can perform a download request
protocol NetworkLoader {
    
    /// Delegate object that can handle network layer results
    var delegate: NetworkLoaderDelegate? { get set }
    
    /// Download a file using the given request
    func download(request: FileDownloadRequest)
}

/// Protocol representing an object that can handle network layer results
protocol NetworkLoaderDelegate: AnyObject {
    
    /// Called when the requested file is ready
    func networkLoader(didReceiveFile: RequestedFile)
    
    /// Called when a progress update is available
    func networkLoader(didReceiveProgress: RequestProgress)
    
    /// Called when a network level error is detected
    func networkLoader(failedWithError: RequestError)
}
