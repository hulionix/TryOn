//
//  EyewearModelPresenterTests.swift
//  TryOnTests
//
//  Created by Ahmed Hussein on 11/15/21.
//

import XCTest
import Combine
@testable import TryOn

class EyewearModelPresenterTests: XCTestCase {
    var underTest: EyewearModelPresenter!
    var eyewearViewMock: EyewearViewMock!
    var interactionsReaderMock: InteractionsReaderMock!
    
    override func setUpWithError() throws {
        self.eyewearViewMock = EyewearViewMock()
        self.interactionsReaderMock = InteractionsReaderMock()
        self.underTest = EyewearModelPresenter(interactionsReader: self.interactionsReaderMock)
        self.underTest.view = self.eyewearViewMock
    }
    
    
    func testPresentEyewearModel() {
        // Given
        let modelName = "A"
        let baseURLString = "base_url"
        let eyewearModel = EyewearModel(name: modelName, baseURL: URL(string: baseURLString)!)
        let expectedURLString = baseURLString + "/" + modelName + AppConfig.modelExtension
        let expected = EyewearViewModel(url: URL(string: expectedURLString)!)
        // When
        self.underTest.present(eyewearModel: eyewearModel)
        
        // Then
        XCTAssertEqual(eyewearViewMock.showEyewearViewModelCalls, 1)
        XCTAssertNotNil(eyewearViewMock.viewModel)
        XCTAssertEqual(eyewearViewMock.viewModel, expected)
    }
    
    
    func testProgressOneHidesProgressView() {
        // When
        self.underTest.update(progress: RequestProgress(0))
        self.underTest.update(progress: RequestProgress(0.3))
        self.underTest.update(progress: RequestProgress(0.5))
        self.underTest.update(progress: RequestProgress(0.8))
        
        // Then
        XCTAssertEqual(eyewearViewMock.showLoadingProgressCalls, 4)
        XCTAssertEqual(eyewearViewMock.hideProgressViewCalls, 0)
        
        // When
        self.underTest.update(progress: RequestProgress(1.0))
        
        // Then
        XCTAssertEqual(eyewearViewMock.showLoadingProgressCalls, 5)
        XCTAssertEqual(eyewearViewMock.hideProgressViewCalls, 1)
    }
    
    
    /// Interactions tests
    func testSnapshotButtonTappedCallsTakeSnapshot() {
        // When
        self.interactionsReaderMock.snapButtonTapsSubject.send()
        
        // Then
        XCTAssertEqual(eyewearViewMock.takeSnapshotCalls, 1)
    }
    
    func testCloseButtonTappedCallsCloseImageViewer() {
        // When
        self.interactionsReaderMock.closeButtonTapsSubject.send()
        
        // Then
        XCTAssertEqual(eyewearViewMock.closeImageViewerCalls, 1)
    }
    
    func testShareButtonTappedCallsShareImage() {
        // When
        self.interactionsReaderMock.shareButtonTapsSubject.send()
        
        // Then
        XCTAssertEqual(eyewearViewMock.shareImageCalls, 1)
    }
    
    func testTutorialOkTappedCallsDismissTutorialAndRequestModel() {
        // When
        self.interactionsReaderMock.tutorialOkTapsSubject.send()
        
        // Then
        XCTAssertEqual(eyewearViewMock.dismissTutorialCalls, 1)
        XCTAssertEqual(eyewearViewMock.requestEyewearModelCalls, 1)
    }
}

// Mocks

class InteractionsReaderMock: InteractionsReader {
    var snapButtonTaps: AnyPublisher<(), Never> {
        snapButtonTapsSubject.eraseToAnyPublisher()
    }
    var closeButtonTaps: AnyPublisher<(), Never> {
        closeButtonTapsSubject.eraseToAnyPublisher()
    }
    var shareButtonTaps: AnyPublisher<(), Never> {
        shareButtonTapsSubject.eraseToAnyPublisher()
    }
    var tutorialOkTaps: AnyPublisher<(), Never> {
        tutorialOkTapsSubject.eraseToAnyPublisher()
    }
    
    var snapButtonTapsSubject = PassthroughSubject<(), Never>()
    var closeButtonTapsSubject = PassthroughSubject<(), Never>()
    var shareButtonTapsSubject = PassthroughSubject<(), Never>()
    var tutorialOkTapsSubject = PassthroughSubject<(), Never>()
}

class EyewearViewMock: EyewearView {
    
    var showEyewearViewModelCalls = 0
    var viewModel: EyewearViewModel!
    
    var showLoadingProgressCalls = 0
    
    var showErrorCalls = 0
    
    var takeSnapshotCalls = 0
    
    var closeImageViewerCalls = 0
    
    var hideProgressViewCalls = 0

    var shareImageCalls = 0
    
    var dismissTutorialCalls = 0
    
    var requestEyewearModelCalls = 0
    
    func show(eyewearViewModel: EyewearViewModel) {
        showEyewearViewModelCalls += 1
        self.viewModel = eyewearViewModel
    }
    
    func show(loadingProgress: CGFloat) {
        showLoadingProgressCalls += 1
    }
    
    func show(error: String) {
        showErrorCalls += 1
    }
    
    func takeSnapshot() {
        takeSnapshotCalls += 1
    }
    
    func closeImageViewer() {
        closeImageViewerCalls += 1
    }
    
    func hideProgressView() {
        hideProgressViewCalls += 1
    }
    
    func shareImage() {
        shareImageCalls += 1
    }
    
    func dismissTutorial() {
        dismissTutorialCalls += 1
    }
    
    func requestEyewearModel() {
        requestEyewearModelCalls += 1
    }
}
