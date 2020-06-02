//
//  LoginViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/31.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit
import AuthenticationServices

protocol LoginViewControllerDelegate: class {
    func loginDidSuccess(_ viewController: LoginViewController)
}

final class LoginViewController: UIViewController {
    weak var delegate: LoginViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func requestGithubOAuth(_ sender: LoginButton) {
        guard let authURL = try? AuthRequest().urlRequest()?.url else { return }
        
        let session = ASWebAuthenticationSession(
            url: authURL,
            callbackURLScheme: AuthKeys.scheme) { [weak self] callbackURL, error in
                guard error == nil, let callbackURL = callbackURL else { return }
                
                self?.writeToken(from: callbackURL, to: UserDefaults.standard)
                self?.dismiss(animated: true) { [weak self] in
                    guard let self = self else { return }
                    self.delegate?.loginDidSuccess(self)
                }
        }
        session.presentationContextProvider = self
        session.start()
    }
    
    private func writeToken(from callbackURL: URL, to userDefaults: UserDefaults) {
        guard let queryItems = URLComponents(string: callbackURL.absoluteString)?.queryItems,
        let token = queryItems.filter({ $0.name == AuthKeys.payloadKey }).first?.value else { return }
        
        userDefaults.set(token, forKey: "jwt")
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
