//
//  SceneDelegate.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: scene)
        window?.rootViewController = tabBarController()
    }
    
    private func tabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.setTabbedViewControllers(
            [SearchViewController(), BookmarkViewController(), ReservationViewController()],
            animated: true
        )
        return tabBarController
    }
}

extension UITabBarController {
    func setTabbedViewControllers(_ tabedBarViewControllers: [TabbedViewController], animated: Bool) {
        tabedBarViewControllers.forEach { $0.configureTabBarItem() }
        setViewControllers(tabedBarViewControllers, animated: animated)
    }
}
