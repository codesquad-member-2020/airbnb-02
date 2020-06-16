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
    static func addObserver(
        object obj: Any? = nil,
        queue: OperationQueue? = nil,
        using block: @escaping (Notification) -> Void
    ) -> NotificationToken {
        let token = NotificationCenter.default
            .addObserver(forName: update, object: obj, queue: queue) { block($0) }
        return NotificationToken(token: token, center: NotificationCenter.default)
    }
}
