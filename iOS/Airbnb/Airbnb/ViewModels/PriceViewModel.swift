//
//  PriceViewModel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/04.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class PriceViewModel {
    private let prices: [(key: Int, value: Int)]
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    
    init(prices: [(key: Int, value: Int)]) {
        self.prices = prices
    }
    
    var priceRangeText: String? {
        guard let first = prices.first, let last = prices.last,
            let minPrice = formatter.string(from: first.key as NSNumber),
            let maxPrice = formatter.string(from: last.key as NSNumber) else { return nil }
        
        return "\(minPrice)원부터 \(maxPrice)원 이상"
    }
    
    var priceAvarageText: String? {
        guard let avarage = formatter.string(
            from: generateAverage() as NSNumber
            ) else { return nil }
        
        return  "일박 평균 가격은 \(avarage)원"
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
