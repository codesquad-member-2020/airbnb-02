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
    private let requestQueue = DispatchQueue(label: "bnbsRequest.serial.queue")
    
    init(bnbsTask: BNBsTask, handler: @escaping ([BNB]?) -> () = { _ in }) {
        self.bnbsTask = bnbsTask
        self.handler = handler
    }
    
    func updateNotify(handler: @escaping ([BNB]?) -> ()) {
        self.handler = handler
    }
    
    func append(bnbsRequest: BNBsRequest) {
        requestQueue.async { [weak self] in
            self?.requestBNBs(bnbsRequest)
        }
    }
    
    private func requestBNBs(_ bnbsRequest: BNBsRequest) {
        bnbsTask.perform(bnbsRequest) { [weak self] bnbs in
            self?.handler(bnbs)
        }
    }
}
