//
//  FilterHeaderView.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class FilterHeaderView: UIView {
    let closeButton = UIButton()
    let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureViewConstraints()
        configureCloseButton()
        configureTitleLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureViewConstraints()
        configureCloseButton()
        configureTitleLabel()
    }
    
    private func configureViewConstraints() {
        translatesAutoresizingMaskIntoConstraints = false
        heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    private func configureCloseButton() {
        closeButton.setImage(#imageLiteral(resourceName: "close"), for: .normal)
        configureCloseButtonConstraints()
    }
    
    private func configureCloseButtonConstraints() {
        addSubview(closeButton)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        closeButton.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        closeButton.widthAnchor.constraint(equalToConstant: 25).isActive = true
        closeButton.heightAnchor.constraint(equalTo: closeButton.widthAnchor).isActive = true
    }
    
    private func configureTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        configureTitleLabelConstraints()
    }
    
    private func configureTitleLabelConstraints() {
        addSubview(titleLabel)
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }
}
