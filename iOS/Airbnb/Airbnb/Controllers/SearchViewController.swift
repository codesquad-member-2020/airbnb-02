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
                guard let vc = FilterViewController.instantiate(from: .filters) else { return }
                vc.modalPresentationStyle = .overCurrentContext
                vc.filterType = filterType
                self?.present(vc, animated: true)
            }
        }
    }
}
