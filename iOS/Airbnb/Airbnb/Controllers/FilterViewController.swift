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
    
    private var subViewController: FilterSubViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        subViewController?.delegate = self
        
        configureBackgroundDim()
        displaySubViewController()
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
        subViewController: FilterSubViewController?
    ) -> Self? {
        guard let viewController = storyboard.load(viewControllerType: self) else { return nil }
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        viewController.subViewController = subViewController
        return viewController
    }
}

extension FilterViewController: CalendarDelegate {
    func durationFromToday(_ viewController: CalendarViewController) -> DateComponents {
        return DateComponents(year: 1)
    }
}
