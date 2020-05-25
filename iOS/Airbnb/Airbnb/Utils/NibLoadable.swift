//
//  NibLoadable.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol NibLoadable: IdentifiableView where Self: UIView { }

extension NibLoadable {
    func loadViewFromNib() -> UIView? {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Self.identifier, bundle: bundle)
        return nib.instantiate(withOwner: self, options: nil).first as? UIView
    }
}
