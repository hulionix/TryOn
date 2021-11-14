//
//  EyewearModelPresenter.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation
import CoreGraphics
import Combine

/// Responsible for updating the view with results of getting an eyewear model
class EyewearModelPresenter: GetEyewearModelOutput {
    
    /// The view controlled by the EyewearModelPresenter. Marked weak to break the Interactor -> Presenter -> View -> Interactor reference cycle and set in composition root so it's available before any usage.
    weak var view: EyewearView!
    
    private let interactionsReader: InteractionsReader
    
    private var cancelables: Set<AnyCancellable> = []
    
    init(interactionsReader: InteractionsReader) {
        self.interactionsReader = interactionsReader
        self.setupInteractions()
    }
    
    /// Setup UI Interactions
    private func setupInteractions() {
        self.interactionsReader.snapButtonTaps.sink { [weak self] _ in
            self?.view.takeSnapshot()
        }.store(in: &self.cancelables)
        
        self.interactionsReader.closeButtonTaps.sink { [weak self] _ in
            self?.view.closeImageViewer()
        }.store(in: &self.cancelables)
        
        self.interactionsReader.shareButtonTaps.sink { [weak self] _ in
            self?.view.shareImage()
        }.store(in: &self.cancelables)
    }
    
    /// Called when an eyewear model is ready
    func present(eyewearModel: EyewearModel) {
        let file = eyewearModel.name + ".gltf"
        let eyewearURL = eyewearModel.baseURL.appendingPathComponent(file,
                                                                     isDirectory: false)
        let viewModel = EyewearViewModel(url: eyewearURL)
        self.view.show(eyewearViewModel: viewModel)
    }
    
    /// Called to update loading progress
    func update(progress: RequestProgress) {
        self.view.show(loadingProgress: CGFloat(progress.value))
        if progress.value == 1 {
            self.view.hideProgressView()
        }
    }
    
    /// Called when requesting an eyewear model fails
    func failedWith(error: RequestError) {
        var message = ""
        switch error {
        case .couldNotProcess:
            message = AppConfig.couldNotParse
        case .networkLoadProblem:
            message = AppConfig.couldNotLoadMessage
        }
        
        self.view.show(error: message)
    }
}
