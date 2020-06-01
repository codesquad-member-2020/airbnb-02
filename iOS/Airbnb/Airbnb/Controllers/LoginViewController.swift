//
//  LoginViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/31.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit
import AuthenticationServices

final class LoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func githubButtonDidTouch(_ sender: LoginButton) {
        requestOAuth()
    }
    
    
    private func requestOAuth() {
        guard let authURL = URL(string: "https://example.com/auth") else { return }
        let scheme = "squadbnb:"
        
        let session = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: scheme) { callbackURL, error in
            
        }
        
        session.presentationContextProvider = self
    }
}

extension LoginViewController: ASWebAuthenticationPresentationContextProviding {
    func presentationAnchor(for session: ASWebAuthenticationSession) -> ASPresentationAnchor {
        return view.window!
    }
}

extension LoginViewController: Identifiable { }

extension LoginViewController {
    static func instantiate(
        from storyboard: StoryboardRouter,
        presentationStyle: UIModalPresentationStyle = .fullScreen
    ) -> Self? {
        guard let viewController = storyboard.load(viewControllerType: self) else { return nil }
        viewController.modalPresentationStyle = presentationStyle
        return viewController
    }
}
