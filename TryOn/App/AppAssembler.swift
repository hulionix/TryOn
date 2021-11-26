//
//  AppAssembler.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import Foundation
import UIKit

class AppAssembler {
    // Register app single instances
    let fileManagerAdapter = FileManagerAdapter()
    lazy var presenter = {
        EyewearModelPresenter(interactionsReader: resolve())
    }()
    let interactionsManager = InteractionsManager()
    // END app single instances
    
    func resolve() -> NetworkLoader {
        AFNetworkAdapter()
    }
    
    func resolve() -> FileReader {
        fileManagerAdapter
    }
    
    func resolve() -> Unarchiver {
        ZipArchiveAdapter(fileWriter: fileManagerAdapter)
    }
    
    func resolve() -> EyewearModelRequester {
        EyewearModelNetworkRequester(fileReader: resolve(),
                                     networkLoader: resolve(),
                                     unarchiver: resolve())
    }
    
    func resolve() -> GetEyewearModel {
        GetEyewearModel(requester: resolve(), output: self.presenter)
    }
    
    func resolve() -> InteractionsWriter {
        interactionsManager
    }
    
    func resolve() -> InteractionsReader {
        interactionsManager
    }
    
    func resolve() -> OverlayViewController {
        OverlayViewController(interactionsWriter: resolve())
    }
    
    func resolve() -> TryOnViewController {
        let viewController = TryOnViewController(overlayViewController: resolve(),
                                                 getEyewearModel: resolve())
        // Completing the view -> interactor -> presenter -> view cycle. RecipesPresenter.view is a weak var to prevent the reference cycle and allow RecipesViewController to deallocate.
        presenter.view = viewController
        return viewController
    }
}
