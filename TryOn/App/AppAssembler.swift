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
    // END app single instances
    
    func resolve() -> NetworkLoader {
        AFNetworkAdapter()
    }
    
    func resolve() -> FileReader {
        fileManagerAdapter
    }
    
    func resolve() -> Unarchiver {
        ZipArchiveAdapter()
    }
    
    func resolve() -> EyewearModelRequester {
        EyewearModelNetworkRequester(fileReader: resolve(),
                                     networkLoader: resolve(),
                                     unarchiver: resolve())
    }
    
    func resolve() -> GetEyewearModel {
        GetEyewearModel(requester: resolve())
    }
    
    func resolve() -> UIViewController {
        let viewController = TryOnViewController(getEyewearModel: resolve())
        return viewController
    }
}
