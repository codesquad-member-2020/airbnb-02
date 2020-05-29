//
//  BNBsTask.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class BNBsTask: NetworkTask {
    typealias Input = BNBsRequest
    typealias Output = [BNB]

    private let networkDispatcher: NetworkDispatcher

    init(networkDispatcher: NetworkDispatcher) {
        self.networkDispatcher = networkDispatcher
    }

    func perform(_ request: BNBsRequest, completionHandler: @escaping ([BNB]?) -> ()) {
        networkDispatcher.execute(request: request) { data, urlResponse, error in
            guard let data = data else { return }
            let bnbs = try? JSONDecoder().decode([BNB].self, from: data)
            completionHandler(bnbs)
        }
    }
}
