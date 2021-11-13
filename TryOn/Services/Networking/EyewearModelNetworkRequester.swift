//
//  EyewearModelRequester.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import Foundation

/// Responsible for requesting an eyewear model through the network
class EyewearModelNetworkRequester: EyewearModelRequester, NetworkLoaderDelegate {
    
    /// Delegate object for handling request results
    weak var delegate: EyewearModelRequesterDelegate?
    
    /// Requester responsible for checking the cache before requesting through the network
    private let fileReader: FileReader
    
    /// Network loading interface
    private var networkLoader: NetworkLoader
    
    /// Service for unarchiving a zipped file
    private var unarchiver: Unarchiver
    
    init(fileReader: FileReader, networkLoader: NetworkLoader, unarchiver: Unarchiver) {
        self.fileReader = fileReader
        self.networkLoader = networkLoader
        self.unarchiver = unarchiver
        self.networkLoader.delegate = self
    }
    
    /// Requests a model with the given name. Checks the local cache first before hitting the network
    func requestModel(named modelName: String) {
        
        // 1. Check cache
        let cacheRequest = FileReadRequest(path: modelName,
                                           isDirectory: true,
                                           baseDirectory: NetworkingConfig.downloadDestination)
        
        if let url = fileReader.getURLIfExists(request: cacheRequest) {
            let model = EyewearModel(name: AppConfig.demoModelName, baseURL: url)
            self.delegate?.requester(didReceiveProgress: RequestProgress(1))
            self.delegate?.requester(didReceiveEyewearModel: model)
            return
        }
        
        // 2. Check network
        let fileName = modelName + NetworkingConfig.downloadExtension
        let url = [
            NetworkingConfig.fetchModelEndpoint,
            fileName,
            NetworkingConfig.fetchModelQueryString
        ].joined(separator: "")
        
        let networkRequest = FileDownloadRequest(url: url,
                                                 fileName: modelName,
                                                 fileExtension: NetworkingConfig.downloadExtension,
                                                 destination: NetworkingConfig.downloadDestination,
                                                 overrideExisting: true)
        
        self.networkLoader.download(request: networkRequest)
    }
    
    /// Called when the requested file is ready
    func networkLoader(didReceiveFile file: RequestedFile) {
        let extractDestination = FileURLRequest(path: nil,
                                                isDirectory: true,
                                                baseDirectory: NetworkingConfig.extractDestination)
        guard let destinationURL = self.fileReader.makeURL(request: extractDestination) else {
            self.delegate?.requester(failedWithError: .couldNotProcess)
            return
        }
        
        let archivedFile = ArchivedFile(url: file.url, unarchiveDestination: destinationURL)
        if self.unarchiver.unarchive(file: archivedFile) {
            let baseURL = destinationURL.appendingPathComponent(file.fileName, isDirectory: true)
            let model = EyewearModel(name: AppConfig.demoModelName, baseURL: baseURL)
            self.delegate?.requester(didReceiveEyewearModel: model)
            return
        }
        
        self.delegate?.requester(failedWithError: .couldNotProcess)
    }
    
    /// Called when a progress update is available
    func networkLoader(didReceiveProgress progress: RequestProgress) {
        self.delegate?.requester(didReceiveProgress: progress)
    }
    
    /// Called when a network level error is detected
    func networkLoader(failedWithError error: RequestError) {
        self.delegate?.requester(failedWithError: error)
    }
}
