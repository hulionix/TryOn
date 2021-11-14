//
//  EyewearModelPresenter.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation

/// Responsible for updating the view with results of getting an eyewear model
class EyewearModelPresenter: GetEyewearModelOutput {
    
    /// The view controlled by the EyewearModelPresenter. Marked weak to break the Interactor -> Presenter -> View -> Interactor reference cycle and set in composition root so it's available before any usage.
    weak var view: EyewearModelView!
    
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
        self.view.show(loadingProgress: progress.value)
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
