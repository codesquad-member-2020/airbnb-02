//
//  BNBCell.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class BNBCell: UICollectionViewCell {
    @IBOutlet weak var imagePagingView: ImagePagingView!
    @IBOutlet weak var badgeLabel: BadgeLabel!
    @IBOutlet weak var bnbTypeLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var reviewCountLabel: ReviewCountLabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var favoriteButton: FavoriteButton!
    
    func configure(with bnb: BNB) {
        badgeLabel.isHidden = !bnb.superhost
        bnbTypeLabel.text = bnb.type
        locationLabel.text = bnb.location
        ratingLabel.text = "\(bnb.review.rating)"
        reviewCountLabel.setText(to: bnb.review.count)
        titleLabel.text = bnb.title
        favoriteButton.isFavorited = bnb.favorite
        imagePagingView.configure(count: bnb.images.count)
    }
    
    override func prepareForReuse() {
        imagePagingView.initCurrentPage()
    }
}

extension BNBCell: Identifiable { }
