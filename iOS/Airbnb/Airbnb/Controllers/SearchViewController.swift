//
//  SearchViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    @IBOutlet weak var test: ImagePagingView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        test.configure(count: 3)
        test.insert(at: 0, image: #imageLiteral(resourceName: "봄날은 간다"))
        test.insert(at: 1, image: #imageLiteral(resourceName: "봄날은 간다2"))
        test.insert(at: 2, image: #imageLiteral(resourceName: "봄날은 간다3"))
    }
}
