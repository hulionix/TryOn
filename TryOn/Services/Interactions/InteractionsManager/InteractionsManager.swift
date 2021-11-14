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
    
    /// Subject for share button taps
    private let shareButtonTapsSubject: PassthroughSubject<(), Never>
    
    /// Snap button taps publisher
    lazy var snapButtonTaps: AnyPublisher<(), Never> = {
        return self.snapButtonTapsSubject.share().eraseToAnyPublisher()
    }()
    
    /// Close button taps publisher
    lazy var closeButtonTaps: AnyPublisher<(), Never> = {
        return self.closeButtonTapsSubject.share().eraseToAnyPublisher()
    }()
    
    /// Share button taps publisher
    lazy var shareButtonTaps: AnyPublisher<(), Never> = {
        return self.shareButtonTapsSubject.share().eraseToAnyPublisher()
    }()
    
    init() {
        self.snapButtonTapsSubject = PassthroughSubject<(), Never>()
        self.closeButtonTapsSubject = PassthroughSubject<(), Never>()
        self.shareButtonTapsSubject = PassthroughSubject<(), Never>()
    }
    
    /// Register a snap button tap
    func snapButtonTapped() {
        self.snapButtonTapsSubject.send()
    }
    
    /// Register a close button tap
    func closeButtonTapped() {
        self.closeButtonTapsSubject.send()
    }
    
    /// Register a close button tap
    func shareButtonTapped() {
        self.shareButtonTapsSubject.send()
    }
}
