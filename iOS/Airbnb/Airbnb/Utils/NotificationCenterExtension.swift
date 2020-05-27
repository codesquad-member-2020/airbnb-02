//
//  NotificationCenterExtension.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/27.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

extension NotificationCenter {
    func addObserver(forName name: NSNotification.Name?,
                     using block: @escaping (Any?) -> Void) -> NotificationToken {
        let token = addObserver(forName: name, object: nil, queue: .main) { block($0.object) }
        return NotificationToken(token: token, center: self)
    }
}
