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
    let presenter = EyewearModelPresenter()
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
    
    func resolve() -> UIViewController {
        let viewController = TryOnViewController(getEyewearModel: resolve())
        // Completing the view -> interactor -> presenter -> view cycle. RecipesPresenter.view is a weak var to prevent the reference cycle and allow RecipesViewController to deallocate.
        presenter.view = viewController
        return viewController
    }
}
