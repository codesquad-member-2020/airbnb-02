//
//  BNBsUseCase.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class BNBsUseCase {
    private let bnbsTask: BNBsTask
    private var handler: ([BNB]?) -> ()
    private var bnbRequests = [BNBsRequest]() { didSet { requestBNBs() } }
    
    init(bnbsTask: BNBsTask, handler: @escaping ([BNB]?) -> () = { _ in }) {
        self.bnbsTask = bnbsTask
        self.handler = handler
    }
    
    func updateNotify(handler: @escaping ([BNB]?) -> ()) {
        self.handler = handler
    }
    
    func append(bnbRequest: BNBsRequest) {
        bnbRequests.append(bnbRequest)
    }
    
    private func requestBNBs() {
        guard let bnbRequest = bnbRequests.pop() else { return }
        
        bnbRequests.removeFirst()
        bnbsTask.perform(bnbRequest) { [weak self] bnbs in
            self!.handler(bnbs)
        }
    }
}
