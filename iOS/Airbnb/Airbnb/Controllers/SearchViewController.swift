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
    
    private let bnbsViewModel = BNBViewModels()
    private let layoutDelegate = BNBsLayout()
    private let bnbsUseCase = BNBsUseCase(bnbsTask: SearchTask(networkDispatcher: AFSession()))
    private let imageUseCase = ImageUseCase(networkDispatcher: AFSession())
    
    private var bnbsToken: NotificationToken?
    private var bnbToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservers()
        configureButtonActions()
        configureCollectionView()
        configureUseCase()
        fetchBNBs()
    }
    
    private func fetchBNBs() {
        bnbsUseCase.request(SearchRequest())
    }
    
    @IBAction func toggleFavorite(_ sender: FavoriteButton) {
        sender.toggle()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = bnbsViewModel
        collectionView.delegate = layoutDelegate
    }
    
    private func configureObservers() {
        bnbsToken = BNBViewModels.Notification.addObserver { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        bnbToken = BNBViewModel.Notification.addObserver { [weak self] notification in
            guard let bnbID = notification.userInfo?["bnbID"] as? Int else { return }
            self?.collectionView.reloadItems(at: [IndexPath(row: bnbID - 1, section: 0)])
        }
    }
    
    private func configureButtonActions() {
        filterButtons.forEach { button in
            button.action = { [weak self] viewController in
                guard let filterViewController = FilterViewController
                    .instantiate(from: .filters, subViewController: viewController) else { return }
                self?.insertPricesIf(viewController)
                self?.present(filterViewController, animated: true)
            }
        }
    }
    
    private func insertPricesIf(_ viewController: UIViewController?) {
        guard let priceViewController = viewController as? PriceViewController else { return }
        
        var prices = [Int: Int]()
        bnbsViewModel.repeatViewModels {
            let price = $0.bnb.price
            if let count = prices[$0.bnb.price] {
                prices.updateValue(count + 1, forKey: price)
            } else {
                prices.updateValue(1, forKey: price)
            }
        }
        priceViewController.prices = prices.sorted(by: <)
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
                imageUseCase.request(imageURL: url)
            }
        }
    }
}
