//
//  BNBTabBarController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class BNBTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BNBTabBarController: Identifiable { }

extension BNBTabBarController {
    static func instantiate(from storyboard: StoryboardRouter) -> Self? {
          return storyboard.load(viewControllerType: self)
      }
}
