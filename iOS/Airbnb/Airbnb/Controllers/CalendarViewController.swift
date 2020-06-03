//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/02.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class CalendarViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var viewModel = CalendarViewModel()
    private var layoutDelegate = CalendarLayout()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = viewModel
        collectionView.delegate = layoutDelegate
    }
}

extension CalendarViewController: Identifiable { }

extension CalendarViewController {
    static func instantiate(from storyboard: StoryboardRouter = .calendar) -> Self? {
        guard let viewController = storyboard.load(viewControllerType: self) else { return nil }
        return viewController
    }
}
