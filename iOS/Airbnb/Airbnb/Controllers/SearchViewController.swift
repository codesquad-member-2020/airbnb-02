//
//  SearchViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addFilter(_ sender: FilterButton) {
        guard let vc = FilterViewController.instantiate(from: .filters) else { return }
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
}
