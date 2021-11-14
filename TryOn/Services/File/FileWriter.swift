//
//  FileWriter.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation

/// Protocol representing an object that can handle file writing operations
protocol FileWriter {
    
    /// Deletes a file or directory at the given URL
    func delete(url: URL) -> Bool
}
