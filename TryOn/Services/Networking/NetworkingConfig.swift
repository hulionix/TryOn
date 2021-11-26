//
//  NetworkingConfig.swift
//  HelloApp
//
//  Created by Ahmed Hussein on 11/9/21.
//

import Foundation

/// Networking configuration constants
struct NetworkingConfig {
    
    /// Endpoint for downloading the model file
    static let fetchModelEndpoint = "https://firebasestorage.googleapis.com/v0/b/brilin-d117f.appspot.com/o/ARModel%2F"
    
    /// Query string for the endpoint
    static let fetchModelQueryString = "?alt=media&token=601ff0b5-9f6f-4c76-9222-14867b4f64c1"
    
    /// Downloaded file extension
    static let downloadExtension = ".zip"
    
    /// Download destination
    static let downloadDestination: FileManager.SearchPathDirectory = .cachesDirectory
    
    /// Extract destination
    static let extractDestination: FileManager.SearchPathDirectory = .cachesDirectory
}
