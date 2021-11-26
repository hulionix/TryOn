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
    
    /// File writer
    let fileWriter: FileWriter
    
    init(fileWriter: FileWriter) {
        self.fileWriter = fileWriter
    }
    
    /// Unarchives an ArchivedFile into its unarchiveDestination
    func unarchive(file: ArchivedFile, deleteAfter: Bool = true) -> Bool {
        if SSZipArchive.unzipFile(atPath: file.url.path,
                                  toDestination: file.unarchiveDestination.path) {
            let _ = self.fileWriter.delete(url: file.url)
            return true
        }
        return false
    }
}
