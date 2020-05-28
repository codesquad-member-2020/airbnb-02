//
//  Observable.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

protocol Observable {
    static var update: Notification.Name { get }
}

extension Observable {
    static func addObserver(using block: @escaping (Any?) -> Void) -> NotificationToken {
        let token = NotificationCenter.default.addObserver(forName: update, object: nil, queue: .main) { block($0.object) }
        return NotificationToken(token: token, center: NotificationCenter.default)
    }
}
