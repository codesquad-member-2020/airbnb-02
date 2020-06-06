//
//  CalendarCell.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/06/03.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

class CalendarCell: UICollectionViewCell {
    enum State {
        case startSelected, endSelected, staying, normal
    }
    
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var leftGrayView: UIView!
    @IBOutlet weak var rightGrayView: UIView!
    @IBOutlet weak var blackRoundView: UIView!
    
    var state: State = .normal {
        didSet { changeState(to: state) }
    }
    
    override func prepareForReuse() {
        dayLabel.text = nil
        setAllViewsHidden()
    }
    
    private func changeState(to state: State) {
        setAllViewsHidden()
        switch state {
        case .startSelected:
            blackRoundView.isHidden = false
            rightGrayView.isHidden = false
        case .endSelected:
            blackRoundView.isHidden = false
            leftGrayView.isHidden = false
        case .staying:
            rightGrayView.isHidden = false
            leftGrayView.isHidden = false
        case .normal: break
        }
    }
    
    private func setAllViewsHidden() {
        leftGrayView.isHidden = true
        rightGrayView.isHidden = true
        blackRoundView.isHidden = true
    }
}

extension CalendarCell: Identifiable { }
