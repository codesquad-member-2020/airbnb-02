//
//  ViewControllerInstantiator.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol Instantiatable: UIViewController where Self: Identifiable {
    static func instantiate (
        from storyboard: StoryboardRouter?,
        presentationStyle: UIModalPresentationStyle?,
        transitionStyle: UIModalTransitionStyle?
    ) -> Self?
}

extension Instantiatable {
    static func instantiate(
        from storyboard: StoryboardRouter?,
        presentationStyle: UIModalPresentationStyle?,
        transitionStyle: UIModalTransitionStyle?
    ) -> Self? {
        var viewController: Self?
        viewController = storyboard == nil ? Self() : storyboard!.load(viewControllerType: Self.self)
        
        if presentationStyle != nil {
            viewController?.modalPresentationStyle = presentationStyle!
        }
        
        if transitionStyle != nil {
            viewController?.modalTransitionStyle = transitionStyle!
        }
        return viewController
    }
}
