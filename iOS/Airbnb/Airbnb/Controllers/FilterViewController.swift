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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundDim()
        addSubViewController()
        configureTitle()
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func configureBackgroundDim() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    
    private func addSubViewController() {
        guard let viewController = subViewController else { return }
        stackView.insertArrangedSubview(viewController.view, at: 1)
    }
    
    private func configureTitle() {
        filterTitle.text = subViewController?.title
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
