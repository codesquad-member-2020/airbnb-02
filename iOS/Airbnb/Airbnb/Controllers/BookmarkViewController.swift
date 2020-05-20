//
//  BookmarkViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class BookmarkViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BookmarkViewController: TabbedViewController {
    var tabTitle: String? {
        return "즐겨찾기"
    }
    
    var tabImage: UIImage? {
        return UIImage(systemName: "heart.fill")
    }
    
    var tabTag: Int {
        return 1
    }
}
