//
//  Storyboard.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

enum Storyboard: String {
    case main = "Main"
    case filters = "Filters"
    
    var instance: UIStoryboard {
        return UIStoryboard(name: rawValue, bundle: .main)
    }
    
    func load<T: UIViewController>(viewControllerType: T.Type) -> T? where T: IdentifiableView {
        let storyboardID = viewControllerType.identifier
        return instance.instantiateViewController(withIdentifier: storyboardID) as? T
    }
}
