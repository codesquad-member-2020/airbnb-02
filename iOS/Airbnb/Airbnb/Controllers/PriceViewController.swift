//
//  PriceViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class PriceViewController: FilterViewController {
    enum Notification: Observable {
        static let update =  Foundation.Notification.Name("priceDidUpdate")
    }
    
    private var contentView: PriceContentView!
    private var priceViewModel: PriceViewModel?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentView()
        configurePriceRange()
        configurePriceAvarage()
        configureGraphView()
        configureObserver()
    }
    
    private func configureContentView() {
        guard let contentView = PriceContentView.loadViewFromNib(
            bundle: Bundle.main,
            withOwner: self
            ) else { return }
        
        self.contentView = contentView
        add(contentView: contentView)
    }
    
    private func configurePriceRange() {
        contentView.priceRange.text = priceViewModel?.priceRangeText()
    }
    
    private func configureGraphView() {
        contentView.graphView.rangeSlider = contentView.priceRangeSlider
        priceViewModel?.repeatPrices { _, value in
            contentView.graphView.append(data: CGFloat(value))
        }
    }
    
    private func configurePriceAvarage() {
        contentView.priceAverage.text = priceViewModel?.priceAvarageText()
    }
    
    private func configureObserver() {
        token = RangeSlider.Notification.addObserver { [weak self] notification in
            self?.contentView.graphView.setNeedsDisplay()
            self?.updateText(notification)
        }
    }
    
    private func updateText(_ notification: Foundation.Notification) {
        guard let lowerValue = notification.userInfo?["lowerValue"] as? CGFloat,
            let upperValue = notification.userInfo?["upperValue"] as? CGFloat else { return }
        
        contentView.priceRange.text = priceViewModel?.priceRangeText(
            minimumPercent: lowerValue,
            maximumPercent: upperValue
        )
        contentView.priceAverage.text = priceViewModel?.priceAvarageText(
            minimumPercent: lowerValue,
            maximumPercent: upperValue
        )
    }
    
    override var filterTitle: String? {
        return "가격"
    }
    
    override func clear() {
        contentView.priceRangeSlider.clear()
    }
    
    override func complete() {
        notifyMinMaxPrice()
        super.complete()
    }
    
    private func notifyMinMaxPrice() {
        guard let minimumPrice = minimumPrice, let maximumPrice = maximumPrice else { return }
        
        NotificationCenter.default.post(
            name: Notification.update,
            object: self,
            userInfo: ["minimumPrice": minimumPrice, "maximumPrice": maximumPrice]
        )
    }
    
    private var minimumPrice: Int? {
        return priceViewModel?.price(percent: contentView.priceRangeSlider.lowerValue)
    }
    
    private var maximumPrice: Int? {
        return priceViewModel?.price(percent: contentView.priceRangeSlider.upperValue)
    }
    
    func configurePriceViewModel(prices: [(key: Int, value: Int)]) {
        priceViewModel = PriceViewModel(prices: prices)
    }
}
