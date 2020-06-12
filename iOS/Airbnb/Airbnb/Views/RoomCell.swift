//
//  BNBCell.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class RoomCell: UICollectionViewCell {
    @IBOutlet weak var imagePagingView: ImagePagingView!
    @IBOutlet weak var badgeLabel: BadgeLabel!
    @IBOutlet weak var roomTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: ReviewCountLabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: FavoriteButton!
    
    func configure(with room: Room) {
        badgeLabel.isHidden = !room.superhost
        roomTypeLabel.text = room.type
        locationLabel.text = room.location
        ratingLabel.text = "\(room.review.rating)"
        reviewCountLabel.setText(to: room.review.count)
        titleLabel.text = room.title
        favoriteButton.isFavorited = room.favorite
        imagePagingView.configure(count: room.images.count)
    }
    
    override func prepareForReuse() {
        imagePagingView.reset()
    }
}

extension RoomCell: Identifiable { }
