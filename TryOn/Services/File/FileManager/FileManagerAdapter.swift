//
//  fileManagerAdapter.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation

/// Handle file operations
class FileManagerAdapter: FileReader, FileWriter {
    
    /// Tries to get the url of a requested file or directory if it exists
    func getURLIfExists(request: FileReadRequest) -> URL? {
        
        let url = self.makeURL(request: request)
        
        guard
            let fileURL = url, FileManager.default.fileExists(atPath: fileURL.path)
        else { return nil }
        
        return fileURL
    }
    
    /// Make a url from the given request
    func makeURL(request: FileURLRequest) -> URL? {
        let url = FileManager.default.urls(for: request.baseDirectory, in: .userDomainMask).first
        
        if let path = request.path {
            return url?.appendingPathComponent(path, isDirectory: request.isDirectory)
        }
        
        return url
    }
    
    func delete(url: URL) -> Bool {
        if FileManager.default.isDeletableFile(atPath: url.path) {
            do {
                try FileManager.default.removeItem(atPath: url.path)
                return true
            } catch {
                return false
            }
        }
        return false
    }
}
