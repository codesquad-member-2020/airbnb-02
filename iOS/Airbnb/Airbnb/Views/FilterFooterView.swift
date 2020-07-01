//
//  FilterFooterView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class FilterFooterView: UIView {
    let clearButton = UIButton()
    let completeButton = UIButton()
    
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
        clearButton.setTitle("초기화", for: .normal)
        clearButton.setTitleColor(.textGray, for: .normal)
        clearButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
    }
    
    private func configureResetButtonConstraints() {
        addSubview(clearButton)
        
        clearButton.translatesAutoresizingMaskIntoConstraints = false
        clearButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24).isActive = true
        clearButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
    }
    
    private func configureSearchButton() {
        completeButton.backgroundColor = UIColor.searchBlack
        configureSearchButtonTitleLabel()
        configureSearchButtonConstraints()
    }
    
    private func configureSearchButtonTitleLabel() {
        completeButton.setTitle("완료", for: .normal)
        completeButton.setTitleColor(.white, for: .normal)
        completeButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
    }
    
    private func configureSearchButtonConstraints() {
        addSubview(completeButton)
        
        completeButton.translatesAutoresizingMaskIntoConstraints = false
        completeButton.trailingAnchor.constraint(
            equalTo: trailingAnchor,
            constant: -10
        ).isActive = true
        completeButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10).isActive = true
        completeButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        completeButton.heightAnchor.constraint(equalToConstant: 38).isActive = true
    }
}
