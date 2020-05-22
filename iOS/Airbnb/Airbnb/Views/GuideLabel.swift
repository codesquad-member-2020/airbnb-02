//
//  GuideLabel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/21.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class GuideLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureText()
        configureFont()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        configureText()
        configureFont()
    }
    
    private func configureText() {
        text = "날짜와 인원을 선택하시면 가격별 숙소를 추천해드립니다."
        textColor = UIColor.dimGray
    }
    
    private func configureFont() {
        font = UIFont.systemFont(ofSize: 15.5, weight: .medium)
    }
}
