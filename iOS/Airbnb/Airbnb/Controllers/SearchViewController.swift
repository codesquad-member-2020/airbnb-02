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
}

extension SearchViewController: TabbedViewController {
    var tabTitle: String? {
        return "숙소"
    }
    
    var tabImage: UIImage? {
        return UIImage(systemName: "magnifyingglass")
    }
    
    var tabTag: Int {
        return 0
    }
}
