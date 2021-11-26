//
//  OverlayButton.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import UIKit

/// Overlay button
class OverlayButton: UIButton {
    
    /// Tapped callback
    private let tappedCallback: () -> Void

    init(normalImage: UIImage,
         highlightedImage: UIImage,
         tapped: @escaping () -> Void) {
        self.tappedCallback = tapped
        super.init(frame: .zero)
        self.setBackgroundImage(normalImage, for: .normal)
        self.setBackgroundImage(highlightedImage, for: .highlighted)
        self.layer.cornerRadius = UIConfig.overlayButtonRadius
        self.clipsToBounds = true
        self.addTarget(self, action: #selector(highlight), for: .touchDown)
        self.addTarget(self, action: #selector(unhighlight), for: .touchUpOutside)
        self.addTarget(self, action: #selector(tap), for: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    /// Enable highlighted state
    @objc private func highlight() {
        self.isHighlighted = true
    }
    
    /// Disable highlighted state
    @objc private func unhighlight() {
        self.isHighlighted = false
    }
    
    /// Tap detected
    @objc private func tap() {
        self.unhighlight()
        self.tappedCallback()
    }
}
