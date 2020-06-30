//
//  FilterFooterView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class FilterFooterView: UIView {
    let resetButton = UIButton()
    let searchButton = UIButton()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
        configureResetButton()
        configureSearchButton()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
        configureResetButton()
        configureSearchButton()
    }
    
    private func configureView() {
        backgroundColor = .white
        configureViewConstraints()
    }
    
    private func configureViewConstraints() {
        heightAnchor.constraint(equalToConstant: 60).isActive =  true
    }
    
    private func configureResetButton() {
        configureResetButtonTitleLabel()
        configureResetButtonConstraints()
    }
    
    private func configureResetButtonTitleLabel() {
        resetButton.setTitle("초기화", for: .normal)
        resetButton.setTitleColor(.textGray, for: .normal)
        resetButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    private func configureResetButtonConstraints() {
        addSubview(resetButton)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    private func configureSearchButton() {
        searchButton.backgroundColor = UIColor.searchBlack
        configureSearchButtonTitleLabel()
        configureSearchButtonConstraints()
    }
    
    private func configureSearchButtonTitleLabel() {
        searchButton.setTitle("완료", for: .normal)
        searchButton.setTitleColor(.white, for: .normal)
        searchButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func configureSearchButtonConstraints() {
        addSubview(searchButton)
        
        searchButton.translatesAutoresizingMaskIntoConstraints = false
        searchButton.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -10
        ).isActive = true
        searchButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
    }
}
