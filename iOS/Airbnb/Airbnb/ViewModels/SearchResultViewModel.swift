//
//  SearchResultViewModel.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

class SearchResultViewModel: NSObject {
    typealias Key = [BNB]?
    
    private var bnbs: Key = nil {
        didSet { NotificationCenter.default.post(name: .bnbsDidUpdate, object: self) }
    }
    
    init(with bnbs: Key) {
        self.bnbs = bnbs
    }
    
    func update(bnbs: Key) {
        self.bnbs = bnbs
    }
}

extension Notification.Name {
    static let bnbsDidUpdate = Notification.Name("bnbsDidUpdate")
}
