//
//  LoadingView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import UIKit
import SnapKit

/// Model loading progress view
class LoadingView: UIView {
    
    /// Label for loading message
    private var label: UILabel!
    
    /// Interface element for the progress bar
    private var progressBar: CALayer!
    
    /// Current progress
    var progress: CGFloat = 0 {
        didSet {
            self.animateProgress()
        }
    }
    
    init() {
        super.init(frame: .zero)
        createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Create interface elements
    private func createUI() {
        self.clipsToBounds = true
        self.layer.cornerRadius = UIConfig.progressViewHeight / 2
        self.isUserInteractionEnabled = false
        self.backgroundColor = .black
        self.createLabel()
        self.createProgressBar()
        
    }
    
    /// Create the label
    private func createLabel() {
        self.label = UILabel()
        self.label.text = UIConfig.loadingMessage
        self.label.textAlignment = .center
        self.label.textColor = .white
        self.addSubview(label)
        self.label.snp.makeConstraints { make in
            make.left.right.top.equalTo(self)
            make.bottom.equalTo(self.snp.centerY)
        }
    }
    
    /// Create the progress bars
    private func createProgressBar() {
        self.progressBar = CALayer()
        progressBar.backgroundColor = UIColor.purple.cgColor
        self.progressBar.frame = CGRect(x: 0,
                                        y: UIConfig.progressViewHeight/2.0,
                                        width: self.frame.width * progress,
                                        height: UIConfig.progressViewHeight/2.0)
        
        self.layer.addSublayer(progressBar)
    }
    
    /// Hide the view
    func hide() {
        UIView.animate(withDuration: UIConfig.progressHideDuration,
                       delay: UIConfig.progressAnimationDuration,
                       options: []) {
            self.alpha = 0
        }
    }
    
    /// Animate the loading progress
    private func animateProgress() {
        let newFrame = CGRect(x: 0,
                              y: progressBar.frame.minY,
                              width: self.frame.width * progress,
                              height: progressBar.frame.height)
        UIView.animate(withDuration: UIConfig.progressAnimationDuration,
                       delay: 0,
                       options: [.beginFromCurrentState],
                       animations: {
            self.progressBar.frame = newFrame
        })
    }
}
