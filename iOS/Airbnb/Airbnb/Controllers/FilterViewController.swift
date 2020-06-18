//
//  FilterViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

enum FilterType {
    case date, guests, price
    
    var title: String {
        switch self {
        case .date: return "체크인 — 체크아웃"
        case .guests: return "인원"
        case .price: return "가격"
        }
    }
}

final class FilterViewController: UIViewController {
    private let headerView = FilterHeaderView()
    private let footerView = FilterFooterView()
    private let stackView = UIStackView()
    
    var filterType: FilterType?
    
    deinit {
        headerView.closeButton.removeTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundDim()
        configureInnerViews()
        configureTitle()
        configureCloseButton()
    }
    
    private func configureBackgroundDim() {
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
    }
    
    private func configureInnerViews() {
        configureStackView()
        configureHeaderView()
        configureFooterView()
    }
    
    private func configureStackView() {
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        configureStackViewConstraints()
    }
    
    private func configureStackViewConstraints() {
        view.addSubview(stackView)
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        let safeArea = view.safeAreaLayoutGuide
        stackView.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.9).isActive = true
        stackView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
    }
    
    private func configureHeaderView() {
        stackView.addArrangedSubview(headerView)
    }
    
    private func configureFooterView() {
        stackView.addArrangedSubview(footerView)
    }
    
    private func configureTitle() {
        headerView.titleLabel.text = filterType?.title
    }
    
    private func configureCloseButton() {
        headerView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
}

extension FilterViewController: Identifiable { }

extension FilterViewController {
    static func instantiate(
        from storyboard: StoryboardRouter,
        presentationStyle: UIModalPresentationStyle = .overCurrentContext,
        transitionStyle: UIModalTransitionStyle = .crossDissolve,
        filterType: FilterType
    ) -> Self? {
        guard let viewController = storyboard.load(viewControllerType: self) else { return nil }
        viewController.modalPresentationStyle = presentationStyle
        viewController.modalTransitionStyle = transitionStyle
        viewController.filterType = filterType
        return viewController
    }
}
