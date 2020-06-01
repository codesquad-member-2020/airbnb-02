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
    
    @IBAction func reqeustGithubOAuth(_ sender: LoginButton) {
        guard let authURL = URL(string: Endpoints.authURL) else {return }
        
        let session = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: AuthKeys.scheme) { callbackURL, error in
                guard error == nil, let callbackURL = callbackURL else { return }
                
                let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems
                let token = queryItems?.filter({ $0.name == AuthKeys.payloadKey }).first?.value
                
        }
        
        session.presentationContextProvider = self
        session.start()
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
