//
//  OverlayViewController.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/14/21.
//

import Foundation
import UIKit

/// Overlay interface view controller
class OverlayViewController: UIViewController {
    
    /// View holding interface UI elements
    var overlayView: OverlayView!
    
    /// Interactions writer
    private let interactionsWriter: InteractionsWriter
    
    init(interactionsWriter: InteractionsWriter) {
        self.interactionsWriter = interactionsWriter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        let overlayView = OverlayView(interactionsWriter: self.interactionsWriter)
        self.view = overlayView
        self.overlayView = overlayView
    }
    
    func presentShareDialogue(image: UIImage) {
        let items = [image]
        let activity = UIActivityViewController(activityItems: items, applicationActivities: nil)
        if UIDevice.current.userInterfaceIdiom == .pad {
            activity.popoverPresentationController?.sourceView = self.overlayView.screenshotView.shareButton
        }

        self.present(activity, animated: true)
    }
}
