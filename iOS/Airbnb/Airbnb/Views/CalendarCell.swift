//
//  CalendarCell.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    @IBOutlet weak var dayLabel: UILabel!
    
    override func prepareForReuse() {
        dayLabel.text = nil
    }
}

extension CalendarCell: Identifiable { }
