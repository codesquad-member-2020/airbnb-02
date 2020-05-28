//
//  DateButton.swift
//  Airbnb
//
//  Created by Chaewan Park on 2020/05/21.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

final class DateButton: FilterButton {
    override func invokeAction(sender: FilterButton) {
        action?(.date)
    }
}
