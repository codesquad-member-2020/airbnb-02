//
//  PriceViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class PriceViewController: FilterViewController {
    private var contentView: PriceContentView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureContentView()
    }
    
    override var filterTitle: String? {
        return "가격"
    }
    
    private func configureContentView() {
        guard let contentView = PriceContentView().loadViewFromNib() else { return }
        
        self.contentView = contentView
        add(contentView: contentView)
    }
}
