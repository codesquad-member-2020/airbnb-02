//
//  FilterHeaderView.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

@IBDesignable
class FilterHeaderView: UIView {
    
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
        view.frame = bounds
        addSubview(view)
    }
}

extension FilterHeaderView: NibLoadable { }
