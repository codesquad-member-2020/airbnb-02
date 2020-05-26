//
//  FilterViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/26.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

enum FilterType {
    case date, guests, price
    
    var title: String {
        switch self {
        case .date: return "체크인 — 체크아웃"
        case .guests: return "인원"
        case .price: return "가격"
        }
    }
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var filterTitle: UILabel!
    
    var filterType: FilterType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(white: 0, alpha: 0.4)
        configureTitle()
    }
    
    @IBAction func close(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    private func configureTitle() {
        filterTitle.text = filterType?.title
    }
}

extension FilterViewController: IdentifiableView { }

extension FilterViewController {
    static func instantiate(from storyboard: Storyboard) -> Self? {
        return storyboard.load(viewControllerType: self)
    }
}
