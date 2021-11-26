//
//  EyewearModel.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation

/// Domain model representing a Eyewear Model
struct EyewearModel: Codable, Equatable {
    
    /// Model name, serves as a base for different model files
    let name: String
    
    /// Filesystem base url representing the folder the model files are stored in
    let baseURL: URL
}
