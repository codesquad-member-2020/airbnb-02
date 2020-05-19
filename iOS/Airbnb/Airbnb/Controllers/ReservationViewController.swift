//
//  ReservationViewController.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class ReservationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension ReservationViewController: TabbedViewController {
    var tabTitle: String? {
        return "예약"
    }
    
    var tabImage: UIImage? {
        return UIImage(systemName: "person.fill")
    }
    
    var tabTag: Int {
        return 2
    }
}
