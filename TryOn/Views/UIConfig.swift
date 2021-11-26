//
//  UIConfig.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import CoreGraphics

/// UI configuration constants
struct UIConfig {
    /// Initial eyewear model scale factor relative to face
    static let eyewearScaleFactor: Float = 1.05
    /// Initial shift in y-axis
    static let eyewearYShift: Float = 0.025
    /// Initial shift in z-axis
    static let eyewearZShift: Float = -0.025
    /// Progress bar increments animation duration
    static let progressAnimationDuration: CGFloat = 1
    /// Progress bar hiding animation duration
    static let progressHideDuration: CGFloat = 1
    /// Progress view loading message
    static let loadingMessage = "Loading Eyewear"
    /// Progress view width
    static let progressViewWidth: CGFloat = 250
    /// Progress view height
    static let progressViewHeight: CGFloat = 100
    /// Overlay button radius
    static let overlayButtonRadius: CGFloat = 35
    /// Overlay button width
    static let overlayButtonWidth: CGFloat = 70
}
