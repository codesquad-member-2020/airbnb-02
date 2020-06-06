//
//  CalendarViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/02.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

protocol CalendarDelegate: FilterSubViewControllerDelegate {
    func durationFromToday(_ viewController: CalendarViewController) -> DateComponents
}

final class CalendarViewController: FilterSubViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var layoutDelegate = CalendarLayoutDelegate()
    
    private var viewModel: CalendarViewModel?
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "체크인 — 체크아웃"

        configureViewModel()
        configureObserver()
        configureDelegate()
        
        collectionView.dataSource = viewModel
        collectionView.delegate = layoutDelegate
    }
    
    private func configureViewModel() {
        guard let delegate = delegate as? CalendarDelegate else { return }
        let duration = delegate.durationFromToday(self)
        let startDate = Date()
        guard let endDate = Calendar.current.date(byAdding: duration, to: startDate) else { return }
        viewModel = CalendarViewModel(startDate: startDate, endDate: endDate)
    }
    
    private func configureObserver() {
        token = CalendarViewModel.Notification.addObserver { [weak self] _ in
            self?.collectionView.reloadData()
        }
    }
    
    private func configureDelegate() {
        layoutDelegate.didSelectItem = { [weak self] indexPath in
            self?.viewModel?.update(selectedIndexPath: indexPath)
        }
    }
}

extension CalendarViewController: Identifiable { }

extension CalendarViewController {
    static func instantiate(from storyboard: StoryboardRouter = .calendar) -> Self? {
        guard let viewController = storyboard.load(viewControllerType: self) else { return nil }
        return viewController
    }
}
