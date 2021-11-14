//
//  Interactions.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import Combine

/// Protocol representing an object that reads interface interactions
protocol InteractionsReader {
    
    /// Subject for snap button taps
    var snapButtonTaps: AnyPublisher<(), Never> { get }
    
    /// Subject for close button taps
    var closeButtonTaps: AnyPublisher<(), Never> { get }
    
    /// Subject for share button taps
    var shareButtonTaps: AnyPublisher<(), Never> { get }
}

/// Protocol representing an object that registers interface interactions
protocol InteractionsWriter {
    
    /// Register a snap button tap
    func snapButtonTapped()
    
    /// Register a close button tap
    func closeButtonTapped()
    
    /// Register a share button tap
    func shareButtonTapped()
}
