//
//  TutorialView.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/15/21.
//

import Foundation
import UIKit

class TutorialView: UIView {
    
    /// View holding the tutorials image
    var imageDisplayView: UIView = UIView()
    
    /// Tutorial image view
    var imageView: UIImageView = UIImageView()
    
    /// UI interactions writer
    let interactionsWriter: InteractionsWriter
    
    init(interactionsWriter: InteractionsWriter) {
        self.interactionsWriter = interactionsWriter
        super.init(frame: .zero)
        self.createUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// Create UI elements
    func createUI() {
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
        
        // Image View
        self.imageView.image = UIImage(named: "Tutorial")
        self.imageDisplayView.addSubview(self.imageView)
        
        let scale: CGFloat = UIDevice.current.userInterfaceIdiom == .pad ? 0.5 : 0.8
        self.imageView.snp.makeConstraints { make in
            make.width.equalTo(self).multipliedBy(scale)
            make.height.equalTo(self).multipliedBy(scale)
            make.center.equalTo(self.snp.center)
        }
        self.imageView.clipsToBounds = true
        self.imageView.layer.cornerRadius = UIConfig.overlayButtonRadius
        self.imageView.contentMode = .scaleAspectFit
        
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc func tapped(gesture: UITapGestureRecognizer) {
        if gesture.state == .recognized {
            self.interactionsWriter.tutorialOkTapped()
        }
    }
    
    func hide() {
        UIView.animate(withDuration: 0.5) {
            self.alpha = 0
        } completion: { _ in
            self.isUserInteractionEnabled = false
        }
    }
}
