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
    private let roomsUseCase = RoomsUseCase(roomsTask: RoomsTask(networkDispatcher: RoomsSuccessStub()))
    private let roomImageUseCase = RoomImageUseCase(networkDownloader: AF)
    private let imageCache = ImageCache()
    
    private var roomsToken: NotificationToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureObserver()
        configureButtonActions()
        configureCollectionView()
        configureUseCase()
    }
    
    @IBAction func toggleFavorite(_ sender: FavoriteButton) {
        sender.toggle()
    }
    
    private func configureCollectionView() {
        collectionView.dataSource = roomViewModels
        collectionView.delegate = self
    }
    
    private func configureObserver() {
        roomsToken = RoomViewModels.Notification.addObserver { [weak self] _ in
            DispatchQueue.main.async {
                self?.collectionView.reloadData()
            }
        }
    }
    
    private func configureButtonActions() {
        filterButtons.forEach { button in
            presentFilterViewController(by: button)
        }
    }
    
    private func presentFilterViewController(by button: FilterButton) {
        button.action = { [weak self] filterType in
            guard let self = self else { return }
            switch filterType {
            case .date:
                self.present(
                    self.filterViewController(type: CalendarViewController.self),
                    animated: true
                )
            case .price:
                self.present(
                    self.filterViewController(type: PriceViewController.self),
                    animated: true
                )
            }
        }
    }
    
    private func filterViewController<T: FilterViewController>(type: T.Type) -> T {
        guard let filterViewController = ViewControllerInstantiator().instantiate(
            type: T.self,
            from: nil,
            presentationStyle: .overCurrentContext,
            transitionStyle: .crossDissolve
            ) else { return T() }
        
        return filterViewController
    }
    
    private func configureUseCase() {
        roomsUseCase.request(RoomsRequest()) { [weak self] rooms in
            guard let rooms = rooms else { return }
            
            self?.roomViewModels.update(rooms: rooms)
            rooms.forEach { self?.configureRoomImageUseCase($0) }
        }
    }
    
    private func configureRoomImageUseCase(_ room: Room) {
        room.repeatImages { imageURL, _ in
            guard !imageCache.fileExists(url: imageURL) else { return }
            
            roomImageUseCase.download(roomID: room.id, imageURL: imageURL) { [weak self] id in
                guard let id = id else { return }
                
                self?.collectionView.reloadItems(at: [IndexPath(row: id - 1, section: 0)])
            }
        }
    }
}

extension RoomViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: 250)
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAt section: Int
    )-> CGFloat {
        return 30
    }
}
