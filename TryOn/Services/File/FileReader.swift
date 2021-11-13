//
//  File.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/11/21.
//

import Foundation

/// Protocol representing an object that can handle file reading operations
protocol FileReader {
    
    /// Tries to get the url of a requested file or directory
    func getURLIfExists(request: FileReadRequest) -> URL?
    
    /// Make a url from the given request
    func makeURL(request: FileURLRequest) -> URL?
}

/// Data structure representing a request for reading a file or a directory
struct FileReadRequest {
    
    /// Path from the base directory
    let path: String?
    
    /// If path represents a directory or file
    let isDirectory: Bool
    
    /// Base directory for the lookup
    let baseDirectory: FileManager.SearchPathDirectory
}

typealias FileURLRequest = FileReadRequest
