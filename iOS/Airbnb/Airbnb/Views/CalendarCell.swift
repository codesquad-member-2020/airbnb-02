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
        resetCell()
    }
    
    private func changeState(to state: State) {
        resetCell()
        switch state {
        case .startSelected:
            dayLabel.textColor = .white
            blackRoundView.isHidden = false
            rightGrayView.isHidden = false
        case .endSelected:
            dayLabel.textColor = .white
            blackRoundView.isHidden = false
            leftGrayView.isHidden = false
        case .staying:
            rightGrayView.isHidden = false
            leftGrayView.isHidden = false
        case .normal: break
        }
    }
    
    private func resetCell() {
        dayLabel.textColor = .black
        leftGrayView.isHidden = true
        rightGrayView.isHidden = true
        blackRoundView.isHidden = true
    }
}

extension CalendarCell: Identifiable { }
