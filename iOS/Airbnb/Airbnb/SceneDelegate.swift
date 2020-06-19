//
//  SceneDelegate.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let scene = (scene as? UIWindowScene) else { return }
        window = UIWindow(windowScene: scene)
        
        guard let bnbTabBarController = VCInstantiator().instantiate(
            type: BNBTabBarController.self,
            from: .main,
            presentationStyle: nil,
            transitionStyle: nil
            ) else { return }
        
        window?.rootViewController = bnbTabBarController
        window?.makeKeyAndVisible()
        
        if haveNoToken(from: .standard) {
            presentLoginViewController(bnbTabBarController)
        }
    }
    
    private func haveNoToken(from userDefault: UserDefaults) -> Bool {
        return userDefault.string(forKey: "jwt") == nil
    }
    
    private func presentLoginViewController(_ tabBarController: BNBTabBarController) {
        guard let searchViewController = tabBarController.children.first as? RoomViewController,
            let loginViewController = VCInstantiator().instantiate(
                type: LoginViewController.self,
                from: .login,
                presentationStyle: .fullScreen,
                transitionStyle: nil
            ) else { return }
        
        DispatchQueue.main.async {
            searchViewController.present(loginViewController, animated: true)
        }
    }
}
