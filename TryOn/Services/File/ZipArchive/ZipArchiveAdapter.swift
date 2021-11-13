//
//  ZipArchiveAdapter.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation
import ZipArchive

/// Adapter for ZipArchive
class ZipArchiveAdapter: Unarchiver {
    
    /// Unarchives an ArchivedFile into its unarchiveDestination
    func unarchive(file: ArchivedFile) -> Bool {
        return SSZipArchive.unzipFile(atPath: file.url.path, toDestination: file.unarchiveDestination.path)
    }
}
