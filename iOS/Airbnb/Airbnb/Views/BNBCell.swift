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
    @IBOutlet weak var titleLabel: UILabel!
    
}

extension BNBCell: Identifiable { }
