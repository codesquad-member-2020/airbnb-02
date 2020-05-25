//
//  FilterFooterView.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
class FilterFooterView: UIView {
    @IBOutlet weak var completeButton: UIButton!
    
    @IBInspectable var cornerRadius: CGFloat = 6 {
        didSet { completeButton.layer.cornerRadius = cornerRadius }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureView()
    }

    private func configureView() {
        guard let view = loadViewFromNib() else { return }
        view.frame = self.bounds
        self.addSubview(view)
    }
}

extension FilterFooterView: NibLoadable { }
