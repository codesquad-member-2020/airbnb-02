//
//  FilterSubViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/04.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol FilterSubViewControllerDelegate: class { }

class FilterSubViewController: UIViewController {
    weak var delegate: FilterSubViewControllerDelegate?
}
