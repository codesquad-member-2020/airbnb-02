//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/06/18.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class CalendarViewController: FilterViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override var filterTitle: String? {
        return "체크인 — 체크아웃"
    }
}
