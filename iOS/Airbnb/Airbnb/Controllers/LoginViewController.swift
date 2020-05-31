//
//  LoginViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/31.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension LoginViewController: Identifiable { }

extension LoginViewController {
    static func instantiate
        (from storyboard: StoryboardRouter,
         presentationStyle: UIModalPresentationStyle = .fullScreen) -> Self? {
        guard let viewController = storyboard.load(viewControllerType: self) else { return nil }
        viewController.modalPresentationStyle = presentationStyle
        return viewController
    }
}
