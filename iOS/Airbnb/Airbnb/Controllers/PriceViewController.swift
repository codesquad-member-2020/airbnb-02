//
//  PriceViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class PriceViewController: UIViewController {
    enum Notification: Observable {
        static let update =  Foundation.Notification.Name("priceDidUpdate")
    }
    
    @IBOutlet weak var priceRange: UILabel!
    @IBOutlet weak var priceAvarage: UILabel!
    @IBOutlet weak var graphView: GraphView!
    @IBOutlet weak var priceRangeSlider: RangeSlider!
    
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
    
    private func updateText(_ notification: Foundation.Notification) {
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
        
        graphView.setNeedsDisplay()
    }
    
    private func configureGraphView() {
        graphView.rangeSlider = priceRangeSlider
        priceViewModel?.repeatPrices { _, value in
            graphView.data.append(CGFloat(integerLiteral: value))
        }
        graphView.data.append(contentsOf: [0, 0])
    }
    
    func notifyPriceMinMaxPrices() {
        guard let minimumPrice = self.minimumPrice, let maximumPrice = self.maximumPrice else { return }
        NotificationCenter.default.post(
            name: Notification.update,
            object: self,
            userInfo: ["minimumPrice": minimumPrice, "maximumPrice": maximumPrice]
        )
    }
    
    private var minimumPrice: Int? {
        return priceViewModel?.price(minimumPercent: priceRangeSlider.lowerValue)
    }
    
    private var maximumPrice: Int? {
        
        return priceViewModel?.price(maximumPercent: priceRangeSlider.upperValue)
    }
}

extension PriceViewController: Identifiable { }

extension PriceViewController {
    static func instantiate(from storyboard: StoryboardRouter = .price) -> Self? {
        return storyboard.load(viewControllerType: self)
    }
}
