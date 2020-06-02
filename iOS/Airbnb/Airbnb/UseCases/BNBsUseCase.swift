//
//  BNBsUseCase.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class BNBsUseCase {
    private let bnbsTask: SearchTask
    private var handler: ([BNB]?) -> ()
    private let requestQueue = DispatchQueue(label: "bnbsRequest.serial.queue")
    
    init(bnbsTask: SearchTask, handler: @escaping ([BNB]?) -> () = { _ in }) {
        self.bnbsTask = bnbsTask
        self.handler = handler
    }
    
    func updateNotify(handler: @escaping ([BNB]?) -> ()) {
        self.handler = handler
    }
    
    func request(_ request: SearchRequest) {
        requestQueue.async { [weak self] in
            self?.requestBNBs(request)
        }
    }
    
    private func requestBNBs(_ request: SearchRequest) {
        bnbsTask.perform(request) { [weak self] bnbs in
            self?.handler(bnbs)
        }
    }
}
