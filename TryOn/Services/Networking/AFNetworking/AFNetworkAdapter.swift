//
//  AFNetworkAdapter.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import Foundation
import Alamofire

/// Responsible for handling network requests through AlamoFire
class AFNetworkAdapter: NetworkLoader {
    
    /// An object that can handle network layer results
    weak var delegate: NetworkLoaderDelegate?
    
    /// Download a file using the given request
    func download(request: FileDownloadRequest) {
        let destination = self.makeDestinationFrom(request: request)
        
        AF.download(request.url, to: destination)
            .downloadProgress(queue: DispatchQueue.main) { [weak self] progress in
                self?.delegate?.networkLoader(didReceiveProgress: RequestProgress( progress.fractionCompleted))
            }
            .response { [weak self] response in
                if response.error == nil, let url = response.fileURL {
                    let requestedFile = RequestedFile(fileName: request.fileName,
                                                      fileExtension: request.fileExtension,
                                                      url: url)
                    self?.delegate?.networkLoader(didReceiveFile: requestedFile)
                } else {
                    self?.delegate?.networkLoader(failedWithError: .networkLoadProblem)
                }
            }
    }
    
    /// Create destination from request
    private func makeDestinationFrom(request: FileDownloadRequest) -> DownloadRequest.Destination {
        return  { _, _ in
            let documentsURL = FileManager.default.urls(for: request.destination, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(request.fileName + request.fileExtension)

            var options: DownloadRequest.Options = [.createIntermediateDirectories]
            if request.overrideExisting {
                options.insert(.removePreviousFile)
            }

            return (fileURL, options)
        }
    }
}



