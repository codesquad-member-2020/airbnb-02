//
//  BNBViewModel.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/31.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class RoomViewModel {
    typealias Key = Room
    
    var room: Key
    
    init(room: Room) {
        self.room = room
    }
}
