//
//  FavoriteButton.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
final class FavoriteButton: RoundButton {
    @IBInspectable var normalColor: UIColor = .black {
        didSet { configureAppearance() }
    }
    
    @IBInspectable var selectedColor: UIColor = .black {
        didSet { configureAppearance() }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }
    
    private func configureAppearance() {
        let normalImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        setImage(normalImage, for: .normal)
        let selectedImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        setImage(selectedImage, for: .selected)
        tintColor = normalColor
    }
}
