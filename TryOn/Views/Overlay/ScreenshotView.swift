//
//  ScreenshotView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import UIKit
import SnapKit

/// View for displaying screenshot related UI
class ScreenshotView: UIView {
    
    /// Button for taking a screenshot
    var snapButton: UIButton!
    
    /// Button for dismissing the screenshot view
    var closeButton: UIButton!
    
    /// View holding the screenshot image
    var imageDisplayView: UIView = UIView()
    
    /// Screenshot image view
    var imageView: UIImageView = UIImageView()
    
    /// For registering user interactions
    let interactionsWriter: InteractionsWriter
    
    init(interactionsWriter: InteractionsWriter) {
        self.interactionsWriter = interactionsWriter
        super.init(frame: UIScreen.main.bounds)
        //self.isUserInteractionEnabled = false
        self.createUI()
    }
    
    /// Create UI elements
    func createUI() {
        self.createSnapButton()
        self.createImageDisplayView()
        self.createCloseButton()
    }
    
    /// Create snap button
    func createSnapButton() {
        self.snapButton = OverlayButton(normalImage: UIImage(named: "CameraNormal")!,
                                        highlightedImage: UIImage(named: "CameraSelected")!,
                                        tapped: { [weak self] in
            self?.interactionsWriter.snapButtonTapped()
        })
        self.addSubview(self.snapButton)
        self.snapButton.snp.makeConstraints { make in
            make.width.height.equalTo(UIConfig.overlayButtonWidth)
            make.centerX.equalTo(self.snp.centerX)
            make.bottom.equalTo(-40)
        }
    }
    
    /// Create close button
    func createCloseButton() {
        self.closeButton = OverlayButton(normalImage: UIImage(named: "CloseNormal")!,
                                         highlightedImage: UIImage(named: "CloseSelected")!,
                                         tapped: { [weak self] in
            self?.interactionsWriter.closeButtonTapped()
        })
        self.closeButton.layer.cornerRadius = self.closeButton.layer.cornerRadius / 1.5
        self.imageDisplayView.addSubview(self.closeButton)
        self.closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(UIConfig.overlayButtonWidth / 1.5)
            make.right.equalTo(-20)
            make.top.equalTo(30)
        }
    }
    
    func createImageDisplayView() {
        self.addSubview(self.imageDisplayView)
        if !UIAccessibility.isReduceTransparencyEnabled {
            self.imageDisplayView.backgroundColor = .clear
            let blurEffect = UIBlurEffect(style: .dark)
            let blurEffectView = UIVisualEffectView(effect: blurEffect)
            self.imageDisplayView.addSubview(blurEffectView)
            blurEffectView.snp.makeConstraints { make in
                make.left.right.top.bottom.equalTo(self.imageDisplayView)
            }
        } else {
            self.imageDisplayView.backgroundColor = .black
        }
        self.imageDisplayView.snp.makeConstraints { make in
            make.left.right.top.bottom.equalTo(self)
        }
        self.imageDisplayView.alpha = 0
        
        // Image View
        self.imageDisplayView.addSubview(self.imageView)
        self.imageView.snp.makeConstraints { make in
            self.makeImageConstraints(make: make, scale: 1, top: 0)
        }
        
        self.imageView.contentMode = .scaleAspectFit
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func show(image: UIImage) {
        self.imageView.image = image
        self.imageDisplayView.alpha = 1
        self.snapButton.isEnabled = false
        UIView.animate(withDuration: 0.5) {
            self.imageView.snp.remakeConstraints { make in
                self.makeImageConstraints(make: make, scale: 0.7, top: 30)
            }
            self.layoutIfNeeded()
        }
    }
    
    func hideImage() {
        UIView.animate(withDuration: 0.5) {
            self.imageView.snp.remakeConstraints { make in
                self.makeImageConstraints(make: make, scale: 1, top: 0)
            }
            self.layoutIfNeeded()
            self.imageDisplayView.alpha = 0
        } completion: { _ in
            self.snapButton.isEnabled = true
            self.imageView.image = nil
        }
    }
    
    func makeImageConstraints(make: ConstraintMaker, scale: CGFloat, top: CGFloat) {
        make.width.equalTo(self).multipliedBy(scale)
        make.height.equalTo(self).multipliedBy(scale)
        make.centerX.equalTo(self.snp.centerX)
        make.top.equalTo(top)
    }
}
