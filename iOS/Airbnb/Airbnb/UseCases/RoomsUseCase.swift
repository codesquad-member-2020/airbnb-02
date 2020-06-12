//
//  BNBsUseCase.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/28.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class RoomsUseCase {
    private let roomsTask: RoomsTask
    private let requestQueue = DispatchQueue(label: "roomsRequest.serial.queue")
    private let semaphore = DispatchSemaphore(value: 10)
    
    init(roomsTask: RoomsTask) {
        self.roomsTask = roomsTask
    }
    
    func request(_ request: RoomsRequest, completionHandler: @escaping ([Room]?) -> ()) {
        requestQueue.async { [weak self] in
            self?.semaphore.wait()
            self?.requestRooms(request, completionHandler: completionHandler)
        }
    }
    
    private func requestRooms(_ request: RoomsRequest, completionHandler: @escaping ([Room]?) -> ()) {
        roomsTask.perform(request) { [weak self] rooms in
            defer { self?.semaphore.signal() }
            completionHandler(rooms)
        }
    }
}
