//
//  PriceViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class PriceViewController: UIViewController {
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var priceAvarage: UILabel!
    
    var priceViewModel: PriceViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configurePriceRange()
        configurePriceAvarage()
    }
    
    private func configureTitle() {
        title = "가격"
    }
    
    private func configurePriceRange() {
        priceRange.text = priceViewModel?.priceRangeText
    }
    
    private func configurePriceAvarage() {
        priceAvarage.text = priceViewModel?.priceAvarageText
    }
}

extension PriceViewController: Identifiable { }

extension PriceViewController {
    static func instantiate(from storyboard: StoryboardRouter = .price) -> Self? {
        return storyboard.load(viewControllerType: self)
    }
}
