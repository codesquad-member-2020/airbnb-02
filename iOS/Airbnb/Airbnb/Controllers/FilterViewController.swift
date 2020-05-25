//
//  FilterViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
}

extension FilterViewController: IdentifiableView { }

extension FilterViewController {
    static func instantiate(from storyboard: Storyboard) -> Self? {
        return storyboard.load(viewControllerType: self)
    }
}
