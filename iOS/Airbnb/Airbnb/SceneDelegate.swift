//
//  SceneDelegate.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    enum TabBarSymbol {
        static let search = UIImage(systemName: "magnifyingglass")
        static let heart = UIImage(systemName: "heart.fill")
    }
    
    enum TabBarTitle {
        static let bnb = "숙소"
        static let bookmark = "즐겨찾기"
    }
    
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let tabBarController = UITabBarController()
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: TabBarTitle.bnb,
            image: TabBarSymbol.search,
            tag: 0
        )
        let bookmarkViewController = BookmarkViewController()
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: TabBarTitle.bookmark,
            image: TabBarSymbol.heart,
            tag: 1)
        tabBarController.setViewControllers([searchViewController, bookmarkViewController], animated: true)
        window?.rootViewController = tabBarController
    }
}
