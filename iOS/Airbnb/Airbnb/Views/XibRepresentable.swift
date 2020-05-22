//
//  WithXib.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/21.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol XibRepresentable: IdentifiableView {
    func insertXibView()
}

extension XibRepresentable {
    func insertXibView() {
        let bundle = Bundle(for: type(of: self))
        let nib = UINib(nibName: Self.identifier, bundle: bundle)
        guard let view =  nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
        view.frame = bounds
        self.addSubview(view)
    }
}
