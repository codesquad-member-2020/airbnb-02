//
//  SearchViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    @IBOutlet var filterButtons: [FilterButton]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureButtonActions()
    }
    
    private func configureButtonActions() {
        filterButtons.forEach { button in
            button.action = { [weak self] filterType in
                guard let filterViewController = FilterViewController
                    .instantiate(from: .filters, filterType: filterType) else { return }
                self?.present(filterViewController, animated: true)
            }
        }
    }
}
