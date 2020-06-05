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
    @IBOutlet weak var graphView: GraphView!
    
    var priceViewModel: PriceViewModel?
    var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTitle()
        configurePriceRange()
        configurePriceAvarage()
        configureGraphView()
        configureObserver()
    }
    
    private func configureTitle() {
        title = "가격"
    }
    
    private func configurePriceRange() {
        priceRange.text = priceViewModel?.priceRangeText()
    }
    
    private func configurePriceAvarage() {
        priceAvarage.text = priceViewModel?.priceAvarageText()
    }
    
    private func configureObserver() {
        token = RangeSlider.Notification.addObserver { [weak self] notification in
            self?.updateText(notification)
        }
    }
    
    private func updateText(_ notification: Notification) {
        guard let lowerValue = notification.userInfo?["lowerValue"] as? CGFloat,
            let upperValue = notification.userInfo?["upperValue"] as? CGFloat else { return }
        
        priceRange.text = priceViewModel?.priceRangeText(
            minimumPercent: lowerValue,
            maximumPercent: upperValue
        )
        priceAvarage.text = priceViewModel?.priceAvarageText(
            minimumPercent: lowerValue,
            maximumPercent: upperValue
        )
    }
    
    private func configureGraphView() {
        priceViewModel?.repeatPrices { _, value in
            graphView.data.append(CGFloat(integerLiteral: value))
        }
        graphView.data.append(contentsOf: [0, 0, 0])
    }
}

extension PriceViewController: Identifiable { }

extension PriceViewController {
    static func instantiate(from storyboard: StoryboardRouter = .price) -> Self? {
        return storyboard.load(viewControllerType: self)
    }
}
