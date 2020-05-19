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
        static let person = UIImage(systemName: "person.fill")
    }
    
    enum TabBarTitle {
        static let bnb = "숙소"
        static let bookmark = "즐겨찾기"
        static let reservation = "예약"
    }
    
    var window: UIWindow?
    
    private var searchViewController: SearchViewController {
        let searchViewController = SearchViewController()
        searchViewController.tabBarItem = UITabBarItem(
            title: TabBarTitle.bnb,
            image: TabBarSymbol.search,
            tag: 0
        )
        return searchViewController
    }
    
    private var bookmarkViewController: BookmarkViewController {
        let bookmarkViewController = BookmarkViewController()
        bookmarkViewController.tabBarItem = UITabBarItem(
            title: TabBarTitle.bookmark,
            image: TabBarSymbol.heart,
            tag: 1
        )
        return bookmarkViewController
    }
    
    private var reservationViewController: ReservationViewController {
        let reservationViewController = ReservationViewController()
        reservationViewController.tabBarItem = UITabBarItem(
            title: TabBarTitle.reservation,
            image: TabBarSymbol.person,
            tag: 2
        )
        return reservationViewController
    }
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        let tabBarController = UITabBarController()
        tabBarController.setViewControllers(
            [searchViewController, bookmarkViewController, reservationViewController],
            animated: true)
        window?.rootViewController = tabBarController
    }
}
