//
//  BookmarkViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class BookmarkViewController: UIViewController {
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        configureTabBarItem()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureTabBarItem()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension BookmarkViewController: TabbedViewController {
    var tagTitle: String? {
        return "즐겨찾기 "
    }
    
    var image: UIImage? {
        return UIImage(systemName: "heart.fill")
    }
    
    var tag: Int {
        return 1
    }
}
