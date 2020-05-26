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
    
    private var bounceAnimation: CAKeyframeAnimation = {
        let bounceAnimation = CAKeyframeAnimation(keyPath: "transform.scale")
        bounceAnimation.values = [1.0, 1.4, 0.9, 1.02, 1.0]
        bounceAnimation.duration = TimeInterval(0.3)
        bounceAnimation.calculationMode = .cubic
        return bounceAnimation
    }()
    
    var isFavorited: Bool = false {
        didSet { setAppearance(isFavorited: isFavorited) }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureAppearance()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureAppearance()
    }
    
    func toggle() {
        isFavorited.toggle()
    }
    
    private func configureAppearance() {
        let normalImage = UIImage(systemName: "heart")?.withRenderingMode(.alwaysTemplate)
        setImage(normalImage, for: .normal)
        let selectedImage = UIImage(systemName: "heart.fill")?.withRenderingMode(.alwaysTemplate)
        setImage(selectedImage, for: .selected)
        tintColor = normalColor
    }
    
    private func setAppearance(isFavorited: Bool) {
        tintColor = isFavorited ? selectedColor : normalColor
        isSelected = isFavorited
        layer.add(bounceAnimation, forKey: nil)
    }
}
