//
//  PriceViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class PriceViewController: FilterViewController {
    private var contentView: PriceContentView!
    private var priceViewModel: PriceViewModel?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentView()
        configurePriceRange()
        configurePriceAvarage()
        configureObserver()
    }
    
    override var filterTitle: String? {
        return "가격"
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
    
    private func configurePriceAvarage() {
        contentView.priceAverage.text = priceViewModel?.priceAvarageText()
    }
    
    private func configureObserver() {
        token = RangeSlider.Notification.addObserver { [weak self] notification in
            self?.updateText(notification)
        }
    }
    
    private func updateText(_ notification: Notification) {
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
    
    func configurePriceViewModel(prices: [(key: Int, value: Int)]) {
        priceViewModel = PriceViewModel(prices: prices)
    }
}
