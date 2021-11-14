//
//  OverlayView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import UIKit

class OverlayView: UIView {
    var progressView = LoadingView()
    
    init() {
        super.init(frame: UIScreen.main.bounds)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func createUI() {
        self.addSubview(progressView)
        self.progressView.snp.makeConstraints { make in
            make.center.equalTo(self.snp.center)
            make.width.equalTo(UIConfig.progressViewWidth)
            make.height.equalTo(UIConfig.progressViewHeight)
        }
    }
}
