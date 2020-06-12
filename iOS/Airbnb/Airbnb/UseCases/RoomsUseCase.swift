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
    private var handler: ([Room]?) -> ()
    private let requestQueue = DispatchQueue(label: "roomsRequest.serial.queue")
    
    init(roomsTask: RoomsTask, handler: @escaping ([Room]?) -> () = { _ in }) {
        self.roomsTask = roomsTask
        self.handler = handler
    }
    
    func updateNotify(handler: @escaping ([Room]?) -> ()) {
        self.handler = handler
    }
    
    func request(_ request: RoomsRequest) {
        requestQueue.async { [weak self] in
            self?.requestRooms(request)
        }
    }
    
    private func requestRooms(_ request: RoomsRequest) {
        roomsTask.perform(request) { [weak self] rooms in
            self?.handler(rooms)
        }
    }
}
