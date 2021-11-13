//
//  EyewearModelNetworkRequesterTests.swift
//  TryOnTests
//
//  Created by Ahmed Hussein on 11/13/21.
//

import Foundation

import XCTest
@testable import TryOn

class RecipesNetworkRequesterTests: XCTestCase {
    
    var underTest: EyewearModelNetworkRequester!
    var fileReaderMock: FileReaderMock!
    var networkLoaderMock: NetworkLoaderMock!
    var unarchiverMock: UnarchiverMock!
    var requesterDelegateMock: RequesterDelegateMock!
    let destinationURL = "testURL"
    let modelURL = "testURL/Eyewear/"

    override func setUpWithError() throws {
        fileReaderMock = FileReaderMock(url: self.modelURL)
        networkLoaderMock = NetworkLoaderMock(url: self.destinationURL)
        unarchiverMock = UnarchiverMock()
        requesterDelegateMock = RequesterDelegateMock()
        self.underTest = EyewearModelNetworkRequester(fileReader: fileReaderMock,
                                                      networkLoader: networkLoaderMock,
                                                      unarchiver: unarchiverMock)
        self.underTest.delegate = requesterDelegateMock
        self.networkLoaderMock.delegate = self.underTest
    }

    func testRequesterFileInCacheSucceeds() throws {
        // Given
        fileReaderMock.shouldFileExist = true
        let expected = EyewearModel(name: AppConfig.demoModelName,
                                    baseURL: URL(string: self.modelURL)!)
        
        // When
        self.underTest.requestModel(named: AppConfig.demoFileName)
        
        // Then
        XCTAssertEqual(fileReaderMock.getURLIfExistsCalls, 1)
        XCTAssertEqual(networkLoaderMock.downloadCalls, 0)
        XCTAssertEqual(requesterDelegateMock.didReceiveEyewearModelCalls, 1)
        XCTAssertEqual(requesterDelegateMock.eyewearModel, expected)
        XCTAssertEqual(requesterDelegateMock.didReceiveProgressCalls, 1)
        XCTAssertEqual(requesterDelegateMock.failedWithErrorCalls, 0)
        XCTAssertNil(requesterDelegateMock.error)
        XCTAssertEqual(unarchiverMock.unarchiveCalls, 0)
    }
    
    func testRequesterFileThroughNetworkSucceeds() throws {
        // Given
        fileReaderMock.shouldFileExist = false
        unarchiverMock.shouldSucceed = true
        let expected = EyewearModel(name: AppConfig.demoModelName,
                                    baseURL: URL(string: self.modelURL)!)
        
        // When
        self.underTest.requestModel(named: AppConfig.demoFileName)
        
        // Then
        XCTAssertEqual(fileReaderMock.getURLIfExistsCalls, 1)
        XCTAssertEqual(networkLoaderMock.downloadCalls, 1)
        XCTAssertEqual(requesterDelegateMock.didReceiveEyewearModelCalls, 1)
        XCTAssertEqual(requesterDelegateMock.eyewearModel, expected)
        XCTAssertEqual(requesterDelegateMock.didReceiveProgressCalls, 1)
        XCTAssertEqual(requesterDelegateMock.failedWithErrorCalls, 0)
        XCTAssertNil(requesterDelegateMock.error)
        XCTAssertEqual(unarchiverMock.unarchiveCalls, 1)
    }
    
    func testRequesterFileThroughNetworkFails() throws {
        // Given
        fileReaderMock.shouldFileExist = false
        networkLoaderMock.shouldSucceed = false
        // When
        self.underTest.requestModel(named: AppConfig.demoFileName)
        
        // Then
        XCTAssertEqual(fileReaderMock.getURLIfExistsCalls, 1)
        XCTAssertEqual(networkLoaderMock.downloadCalls, 1)
        XCTAssertEqual(requesterDelegateMock.didReceiveEyewearModelCalls, 0)
        XCTAssertEqual(requesterDelegateMock.didReceiveEyewearModelCalls, 0)
        XCTAssertNil(requesterDelegateMock.eyewearModel)
        XCTAssertEqual(requesterDelegateMock.didReceiveProgressCalls, 0)
        XCTAssertEqual(requesterDelegateMock.failedWithErrorCalls, 1)
        XCTAssertEqual(requesterDelegateMock.error, .networkLoadProblem)
        XCTAssertEqual(unarchiverMock.unarchiveCalls, 0)
    }
    
    func testRequesterFileThroughNetworkSucceedsUnarchiverFails() throws {
        // Given
        fileReaderMock.shouldFileExist = false
        networkLoaderMock.shouldSucceed = true
        unarchiverMock.shouldSucceed = false
        // When
        self.underTest.requestModel(named: AppConfig.demoFileName)
        
        // Then
        XCTAssertEqual(fileReaderMock.getURLIfExistsCalls, 1)
        XCTAssertEqual(networkLoaderMock.downloadCalls, 1)
        XCTAssertEqual(requesterDelegateMock.didReceiveEyewearModelCalls, 0)
        XCTAssertEqual(requesterDelegateMock.didReceiveEyewearModelCalls, 0)
        XCTAssertNil(requesterDelegateMock.eyewearModel)
        XCTAssertEqual(requesterDelegateMock.didReceiveProgressCalls, 1)
        XCTAssertEqual(requesterDelegateMock.failedWithErrorCalls, 1)
        XCTAssertEqual(requesterDelegateMock.error, .couldNotProcess)
        XCTAssertEqual(unarchiverMock.unarchiveCalls, 1)
    }
}

// Mocks

class FileReaderMock: FileReader {
    
    var getURLIfExistsCalls = 0
    var makeURLCalls = 0
    var shouldFileExist = true
    var urlString = ""
    
    init(url: String) {
        self.urlString = url
    }
    
    func getURLIfExists(request: FileReadRequest) -> URL? {
        getURLIfExistsCalls += 1
        
        if shouldFileExist {
            return URL(string: self.urlString)!
        }
        
        return nil
    }
    
    func makeURL(request: FileURLRequest) -> URL? {
        makeURLCalls += 1
        return URL(string: "testURL")
    }
}

class NetworkLoaderMock: NetworkLoader {
    var delegate: NetworkLoaderDelegate?
    
    var downloadCalls = 0
    
    var shouldSucceed = true
    
    var urlString = ""
    
    init(url: String) {
        self.urlString = url
    }
    
    func download(request: FileDownloadRequest) {
        downloadCalls += 1
        if shouldSucceed {
            self.delegate?.networkLoader(didReceiveProgress: RequestProgress(1))
            let requestedFile = RequestedFile(fileName: AppConfig.demoFileName,
                                              fileExtension: NetworkingConfig.downloadExtension,
                                              url: URL(string: self.urlString)!)
            self.delegate?.networkLoader(didReceiveFile: requestedFile)
        } else {
            self.delegate?.networkLoader(failedWithError: .networkLoadProblem)
        }
    }
}

class UnarchiverMock: Unarchiver {
    var unarchiveCalls = 0
    var shouldSucceed = true
    
    func unarchive(file: ArchivedFile) -> Bool {
        unarchiveCalls += 1
        return shouldSucceed
    }
}

class RequesterDelegateMock: EyewearModelRequesterDelegate {
    var didReceiveEyewearModelCalls = 0
    var didReceiveProgressCalls = 0
    var failedWithErrorCalls = 0
    var error: RequestError!
    var eyewearModel: EyewearModel!

    func requester(didReceiveEyewearModel model: EyewearModel) {
        didReceiveEyewearModelCalls += 1
        self.eyewearModel = model
    }

    func requester(didReceiveProgress: RequestProgress) {
        didReceiveProgressCalls += 1
    }

    func requester(failedWithError error: RequestError) {
        failedWithErrorCalls += 1
        self.error = error
    }
}

