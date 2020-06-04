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
    
    var prices: [(key: Int, value: Int)]!
    
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
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let first = prices.first,
            let minPrice = formatter.string(from: first.key as NSNumber),
            let last = prices.last,
            let maxPrice = formatter.string(from: last.key as NSNumber) else { return }
        
        priceRange.text = "\(minPrice)원부터 \(maxPrice)원 이상"
    }
    
    private func configurePriceAvarage() {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let avarage = formatter.string(from: generateAverage() as NSNumber) else { return }
        
        priceAvarage.text = "일박 평균 가격은 \(avarage)원"
    }
    
    private func generateAverage() -> Int {
        var totalPrice = 0
        var totalCount = 0
        prices.forEach { price, count in
            totalPrice += price
            totalCount += count
        }
        return Int(totalPrice / totalCount)
    }
}

extension PriceViewController: Identifiable { }

extension PriceViewController {
    static func instantiate(from storyboard: StoryboardRouter = .price) -> Self? {
        return storyboard.load(viewControllerType: self)
    }
}
