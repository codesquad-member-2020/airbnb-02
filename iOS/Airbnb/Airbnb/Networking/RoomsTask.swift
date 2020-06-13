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
        try? networkDispatcher.execute(
            request: request,
            completionHandler: { [weak self] data, urlResponse in
                guard let data = data else { return }
                
                completionHandler(self?.decodeRooms(with: data))
        },
            failureHandler: { urlResponse, error in
                guard let error = error else { return }
                
                print(error.localizedDescription)
                completionHandler(nil)
        })
    }
    
    private func decodeRooms(with data: Data) -> [Room]? {
        return try? JSONDecoder().decode([Room].self, from: data)
    }
}
