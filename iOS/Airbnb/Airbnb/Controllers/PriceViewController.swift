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
    var prices: [(key: Int, value: Int)]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePriceRange()
    }
    
    private func configurePriceRange() {
        guard let minPrice = prices.first?.key, let maxPrice = prices.last?.key else { return }
        priceRange.text = "\(minPrice)원부터 \(maxPrice)원 이상"
    }
}

extension PriceViewController: Identifiable { }

extension PriceViewController {
    static func instantiate(from storyboard: StoryboardRouter = .price) -> Self? {
        return storyboard.load(viewControllerType: self)
    }
}
