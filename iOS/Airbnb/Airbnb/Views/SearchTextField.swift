//
//  SearchBar.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/20.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class SearchTextField: UITextField {
    @IBInspectable var color: UIColor = .black {
        didSet { layer.borderColor = color.cgColor }
    }
    
    @IBInspectable var borderWidth: CGFloat = 1 {
        didSet { layer.borderWidth = borderWidth }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLayer()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureLayer()
    }
    
    private func configureLayer() {
        layer.cornerRadius = 5
        configureShadow()
    }
}

extension SearchTextField: Shadow { }
