//
//  PriceViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class PriceViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension PriceViewController: Identifiable { }

extension PriceViewController {
    static func instantiate(from storyboard: StoryboardRouter = .price) -> Self? {
        return storyboard.load(viewControllerType: self)
    }
}
