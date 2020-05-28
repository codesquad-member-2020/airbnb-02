//
//  BNBsUseCase.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct BNBsUseCase {
    private let bnbsTask: BNBsTask
    private var bnbRequests = [BNBRequest]()
    
    init(bnbsTask: BNBsTask) {
        self.bnbsTask = bnbsTask
    }
    
    mutating func append(bnbRequest: BNBRequest) {
        bnbRequests.append(bnbRequest)
    }
    
    func requestBNBs(completionHandler: @escaping ([BNB]?) -> ()) {
        guard !bnbRequests.isEmpty else { return }
        guard let bnbRequest = bnbRequests.first else { return }
        bnbsTask.perform(bnbRequest) { completionHandler($0) }
    }
}
