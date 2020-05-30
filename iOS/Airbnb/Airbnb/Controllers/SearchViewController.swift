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
    
    private let viewModel = BNBsViewModel()
    private let layoutDelegate = BNBsLayout()
    private let bnbsUseCase = BNBsUseCase(bnbsTask: BNBsTask(networkDispatcher: AF))
    private let imageUseCase = ImageUseCase(networkDispatcher: AF)
    
    private var token: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObserver()
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
        collectionView.dataSource = viewModel
        collectionView.delegate = layoutDelegate
    }
    
    private func configureObserver() {
        token = BNBsViewModel.Notification.addObserver { [weak self] _ in
            self?.collectionView.reloadData()
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
            self?.viewModel.update(bnbs: bnbs)
            
            let cache = ImageCache()
            bnbs?.forEach {
                $0.images.forEach { urlString in
                    guard let url = URL(string: urlString) else { return }
                    guard cache.fileExists(lastPathComponent: url.lastPathComponent) else {
                        self?.imageUseCase.append(imageURL: url)
                        return
                    }
                    
                }
            }
        }
    }
}
