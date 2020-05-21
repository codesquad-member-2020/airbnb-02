//
//  GuideLabelViewModel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/21.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import UIKit

final class GuideLabelViewModel {
    enum Text {
        static let `default` = "날짜와 인원을 선택하시면 가격별 숙소를 추천해드립니다."
    }
    
    enum Font {
        static let `default` = UIFont.systemFont(ofSize: 15.5, weight: .medium)
    }
    
    enum Color {
        static let defaultText = UIColor.dimGray
    }
}
