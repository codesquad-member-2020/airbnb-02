//
//  SearchTask.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class RoomsTask: NetworkTask {
    typealias Input = RoomsRequest
    typealias Output = [Room]

    private let networkDispatcher: NetworkDispatcher

    init(networkDispatcher: NetworkDispatcher) {
        self.networkDispatcher = networkDispatcher
    }

    func perform(_ request: RoomsRequest, completionHandler: @escaping ([Room]?) -> ()) {
        networkDispatcher.execute(request: request) { data, urlResponse, error in
            guard let data = data else { return }
            let rooms = try? JSONDecoder().decode([Room].self, from: data)
            completionHandler(rooms)
        }
    }
}
