//
//  PriceViewModel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/04.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

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
    
    func repeatPrices(handler: (Int, Int) -> ()) {
        prices.forEach { handler($0, $1) }
    }
    
    func priceRangeText(minimumPercent: CGFloat = 0, maximumPercent: CGFloat = 1) -> String? {
        let firstIndex = index(percent: minimumPercent)
        let lastIndex = index(percent: maximumPercent)
        guard let minPrice = formatter.string(from: prices[firstIndex].key as NSNumber),
            let maxPrice = formatter.string(from: prices[lastIndex].key as NSNumber)
            else { return nil }
        
        return "\(minPrice)원부터 \(maxPrice)원 이상"
    }
    
    func priceAvarageText(minimumPercent: CGFloat = 0, maximumPercent: CGFloat = 1) -> String? {
        guard let avarage = generateAverage(minimumPercent: minimumPercent, maximumPercent: maximumPercent), let avaragePrice = formatter.string(
            from: avarage as NSNumber
            ) else { return nil }
        
        return  "일박 평균 가격은 \(avaragePrice)원"
    }
    
    private func generateAverage(minimumPercent: CGFloat, maximumPercent: CGFloat) -> Int? {
        var totalPrice = 0
        var totalCount = 0
        
        let firstIndex = index(percent: minimumPercent)
        let lastIndex = index(percent: maximumPercent)
        guard firstIndex <= lastIndex else { return nil }
        for index in firstIndex ... lastIndex {
            totalPrice += prices[index].key * prices[index].value
            totalCount += prices[index].value
        }
        
        guard totalCount != 0 else { return nil }
        return Int(totalPrice / totalCount)
    }
    
    private func index(percent: CGFloat) -> Int {
        guard Int(percent * CGFloat(prices.count)) > 0 else { return 0 }
        guard Int(percent * CGFloat(prices.count)) < prices.count else { return prices.count - 1 }
        return Int(percent * CGFloat(prices.count))
    }
}
