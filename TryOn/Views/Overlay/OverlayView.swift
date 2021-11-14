//
//  OverlayView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import UIKit

/// View holding interface elements on top of the TryOn view
class OverlayView: UIView {
    
    /// Screenshot view
    var screenshotView: ScreenshotView
    
    /// Progress view
    var progressView = LoadingView()
    
    /// For registering user interactions
    let interactionsWriter: InteractionsWriter
    
    init(interactionsWriter: InteractionsWriter) {
        self.interactionsWriter = interactionsWriter
        self.screenshotView = ScreenshotView(interactionsWriter: self.interactionsWriter)
        super.init(frame: UIScreen.main.bounds)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Create UI elements
    func createUI() {
        self.addSubview(self.screenshotView)
        self.screenshotView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        
        self.addSubview(self.progressView)
        self.progressView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(UIConfig.progressViewWidth)
            make.height.equalTo(UIConfig.progressViewHeight)
        }
    }
}
