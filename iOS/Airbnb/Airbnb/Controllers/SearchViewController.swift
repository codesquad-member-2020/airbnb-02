//
//  SearchViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

import Alamofire

final class SearchViewController: UIViewController {
    @IBOutlet var filterButtons: [FilterButton]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let bnbsViewModel = BNBsViewModel()
    private let layoutDelegate = BNBsLayout()
    private let bnbsUseCase = BNBsUseCase(bnbsTask: BNBsTask(networkDispatcher: AF))
    private let imageUseCase = ImageUseCase(networkDispatcher: AF)
    
    private var bnbsToken: NotificationToken?
    private var bnbToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservers()
        configureButtonActions()
        configureCollectionView()
        configureUseCase()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        bnbsUseCase.append(bnbsRequest: BNBsRequest())
    }
    
    @IBAction func toggleFavorite(_ sender: FavoriteButton) {
        sender.toggle()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = bnbsViewModel
        collectionView.delegate = layoutDelegate
    }
    
    private func configureObservers() {
        bnbsToken = BNBsViewModel.Notification.addObserver { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        bnbToken = BNBViewModel.Notification.addObserver { [weak self] notification in
            guard let bnbID = notification.userInfo?["bnbID"] as? Int else { return }
            self?.collectionView.reloadItems(at: [IndexPath(row: bnbID - 1, section: 0)])
        }
    }
    
    private func configureButtonActions() {
        filterButtons.forEach { button in
            button.action = { [weak self] filterType in
                guard let filterViewController = FilterViewController
                    .instantiate(from: .filters, filterType: filterType) else { return }
                self?.present(filterViewController, animated: true)
            }
        }
    }
    
    private func configureUseCase() {
        bnbsUseCase.updateNotify { [weak self] bnbs in
            guard let bnbs = bnbs else { return }
            
            self?.bnbsViewModel.update(bnbs: bnbs)
            self?.configureImageUseCase(bnbs)
        }
    }
    
    private func configureImageUseCase(_ bnbs: [BNB]) {
        bnbs.forEach {
            $0.images.forEach { urlString in
                guard let url = URL(string: urlString) else { return }
                guard !ImageCache.fileExists(
                    lastPathComponent: url.lastPathComponent
                    ) else { return }
                imageUseCase.append(imageURL: url)
            }
        }
    }
}
