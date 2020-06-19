//
//  Instantiator.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

struct ViewControllerInstantiator {
    func instantiate<T: UIViewController> (
        type: T.Type,
        from storyboard: StoryboardRouter?,
        presentationStyle: UIModalPresentationStyle?,
        transitionStyle: UIModalTransitionStyle?
    ) -> T? where T: Identifiable {
        var viewController: T?
        viewController = storyboard == nil ? T() : storyboard!.load(viewControllerType: T.self)
        
        if presentationStyle != nil {
            viewController?.modalPresentationStyle = presentationStyle!
        }
        
        if transitionStyle != nil {
            viewController?.modalTransitionStyle = transitionStyle!
        }
        return viewController
    }
}
