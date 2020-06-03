//
//  FilterViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class FilterViewController: UIViewController {
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var filterTitle: UILabel!
    

    private var subViewController: UIViewController?
    var prices: [(key: Int, value: Int)]?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundDim()
        displaySubViewController()
        temp_showPriceViewController()
    }
    
    private func temp_showPriceViewController() {
        guard let priceViewController = PriceViewController.instantiate() else { return }
        priceViewController.prices = prices
        
        addChild(priceViewController)
        stackView.insertArrangedSubview(priceViewController.view, at: 1)
        let safeArea = view.safeAreaLayoutGuide
        priceViewController.view.heightAnchor.constraint(equalTo: safeArea.heightAnchor, multiplier: 0.4).isActive = true
        priceViewController.view.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func configureBackgroundDim() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    
    private func displaySubViewController() {
        guard let viewController = subViewController else { return }
        stackView.insertArrangedSubview(viewController.view, at: 1)
        filterTitle.text = viewController.title
    }
}

extension FilterViewController: Identifiable { }

extension FilterViewController {
    static func instantiate(
        from storyboard: StoryboardRouter = .filters,
        presentationStyle: UIModalPresentationStyle = .overCurrentContext,
        transitionStyle: UIModalTransitionStyle = .crossDissolve,
        subViewController: UIViewController?
    ) -> Self? {
        guard let viewController = storyboard.load(viewControllerType: self) else { return nil }
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        viewController.subViewController = subViewController
        return viewController
    }
}
