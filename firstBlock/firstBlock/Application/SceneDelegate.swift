//
//  SceneDelegate.swift
//  firstBlock
//
//  Created by Рустем on 05.02.2024.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        self.window = UIWindow(windowScene: windowScene)
        let tabBarController = TabBarController()
        self.window?.rootViewController = SplashScreen()
        self.window?.makeKeyAndVisible()
        _ = Timer.scheduledTimer(withTimeInterval: 3.0, repeats: false) { _ in
            self.window?.rootViewController = tabBarController
        }

    }

    func sceneDidDisconnect(_ scene: UIScene) {
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
    }

    func sceneWillResignActive(_ scene: UIScene) {
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
    }
}
