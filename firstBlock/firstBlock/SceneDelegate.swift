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
        let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let splashScreenController = mainStoryboard.instantiateViewController(
            withIdentifier: "SplashScreenViewController")
        let mainViewController = mainStoryboard.instantiateViewController(
            withIdentifier: "TabBarController")
        self.window!.rootViewController = splashScreenController
        self.window!.makeKeyAndVisible()
        let navigationController = UINavigationController(rootViewController: mainViewController)
        let _ = Timer.scheduledTimer(withTimeInterval: 2.0, repeats: false) { _ in
            self.window!.rootViewController = navigationController
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

