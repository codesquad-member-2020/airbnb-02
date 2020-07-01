//
//  NibLoadable.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol NibLoadable: Identifiable where Self: UIView { }

extension NibLoadable {
    static func loadViewFromNib(bundle: Bundle, withOwner ownerOrNil: Any?) -> Self? {
        let nib = UINib(nibName: Self.identifier, bundle: bundle)
        return nib.instantiate(withOwner: ownerOrNil, options: nil).first as? Self
    }
}
