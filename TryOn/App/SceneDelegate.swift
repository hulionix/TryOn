//
//  SceneDelegate.swift
//  TryOn
//
//  Created by Ahmed Hussein on 11/10/21.
//

import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let assembler = AppAssembler()
        self.window = UIWindow(windowScene: scene)
        self.window?.rootViewController = assembler.resolve()
        self.window?.makeKeyAndVisible()
    }
}

