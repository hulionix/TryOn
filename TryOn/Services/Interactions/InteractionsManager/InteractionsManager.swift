//
//  InteractionsManager.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import Combine

class InteractionsManager: InteractionsReader, InteractionsWriter {
    
    /// Subject for snap button taps
    private let snapButtonTapsSubject: PassthroughSubject<(), Never>
    
    /// Subject for close button taps
    private let closeButtonTapsSubject: PassthroughSubject<(), Never>
    
    /// Snap button taps publisher
    var snapButtonTaps: AnyPublisher<(), Never> {
        return self.snapButtonTapsSubject.share().eraseToAnyPublisher()
    }
    
    /// Snap button taps publisher
    var closeButtonTaps: AnyPublisher<(), Never> {
        return self.closeButtonTapsSubject.share().eraseToAnyPublisher()
    }
    
    init() {
        self.snapButtonTapsSubject = PassthroughSubject<(), Never>()
        self.closeButtonTapsSubject = PassthroughSubject<(), Never>()
    }
    
    /// Register a snap button tap
    func snapButtonTapped() {
        self.snapButtonTapsSubject.send()
    }
    
    /// Register a close button tap
    func closeButtonTapped() {
        self.closeButtonTapsSubject.send()
    }
}
