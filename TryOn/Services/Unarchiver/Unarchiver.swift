//
//  Unarchiver.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation

/// Protocol representing a service that can provide unarchiving capabilities
protocol Unarchiver {
    
    /// Unarchives an ArchivedFile into its unarchiveDestination
    func unarchive(file: ArchivedFile, deleteAfter: Bool) -> Bool
}

/// Data structure representing an archived file along with it's desired unarchiving destination
struct ArchivedFile {
    let url: URL
    let unarchiveDestination: URL
}
