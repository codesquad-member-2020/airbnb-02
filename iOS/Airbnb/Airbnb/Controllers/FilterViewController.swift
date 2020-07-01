//
//  FilterViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

enum FilterType {
    case date, price
}

class FilterViewController: UIViewController {
    private let headerView = FilterHeaderView()
    private let footerView = FilterFooterView()
    private let stackView = UIStackView()
    
    var filterTitle: String? { return nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundDim()
        configureInnerViews()
        configureTitle()
        configureCloseButton()
        configureClearButton()
        configureCompleteButton()
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
        stackView.widthAnchor.constraint(
            equalTo: safeArea.widthAnchor,
            multiplier: 0.9
        ).isActive = true
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
        headerView.titleLabel.text = filterTitle
    }
    
    private func configureCloseButton() {
        headerView.closeButton.addTarget(self, action: #selector(close), for: .touchUpInside)
    }
    
    @objc private func close() {
        dismiss(animated: true)
    }
    
    func add(contentView: UIView) {
        let contentIndex = 1
        stackView.insertArrangedSubview(contentView, at: contentIndex)
    }
    
    private func configureClearButton() {
        footerView.clearButton.addTarget(self, action: #selector(clear), for: .touchUpInside)
    }
    
    @objc func clear() { }
    
    private func configureCompleteButton() {
        footerView.completeButton.addTarget(self, action: #selector(complete), for: .touchUpInside)
    }
    
    @objc func complete() {
        dismiss(animated: true)
    }
}

extension FilterViewController: Identifiable { }

