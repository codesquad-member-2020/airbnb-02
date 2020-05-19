//
//  TabbedViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol TabbedViewController where Self: UIViewController {
    var tagTitle: String? { get }
    
    var image: UIImage? { get }
    
    var tag: Int { get }
}

extension TabbedViewController {
    func configureTabBarItem() {
        tabBarItem = UITabBarItem(title: tagTitle, image: image, tag: tag)
    }
}
