//
//  SearchViewController.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/19.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

import Alamofire

final class RoomViewController: UIViewController {
    @IBOutlet var filterButtons: [FilterButton]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let roomViewModels = RoomViewModels()
    private let layoutDelegate = BNBsLayout()
    private let roomsUseCase = RoomsUseCase(roomsTask: RoomsTask(networkDispatcher: AFSession()))
    private let imageUseCase = ImageUseCase(networkDispatcher: AFSession())
    
    private var roomsToken: NotificationToken?
    private var roomToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObservers()
        configureButtonActions()
        configureCollectionView()
        configureUseCase()
        fetchRooms()
    }
    
    private func fetchRooms() {
        roomsUseCase.request(RoomsRequest())
    }
    
    @IBAction func toggleFavorite(_ sender: FavoriteButton) {
        sender.toggle()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = roomViewModels
        collectionView.delegate = layoutDelegate
    }
    
    private func configureObservers() {
        roomsToken = RoomViewModels.Notification.addObserver { [weak self] _ in
            self?.collectionView.reloadData()
        }
        
        roomToken = RoomViewModel.Notification.addObserver { [weak self] notification in
            guard let roomID = notification.userInfo?["roomID"] as? Int else { return }
            self?.collectionView.reloadItems(at: [IndexPath(row: roomID - 1, section: 0)])
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
        roomsUseCase.updateNotify { [weak self] rooms in
            guard let rooms = rooms else { return }
            
            self?.roomViewModels.update(rooms: rooms)
            self?.configureImageUseCase(rooms)
        }
    }
    
    private func configureImageUseCase(_ rooms: [Room]) {
        rooms.forEach {
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
