//
//  SceneDelegate.swift
//  iTunesAppHyeonjin
//
//  Created by 유현진 on 5/8/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: windowScene)
        let navigationController = UINavigationController()
        var diContainer = DIContainer()
        navigationController.setViewControllers([HomeViewController(viewModel: diContainer.makeHomeViewModel())], animated: true)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
}
