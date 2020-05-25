//
//  BNB.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct BNB: Codable {
    let id: Int
    let title: String
    let location: String
    let images: [String]
    let price: Int
    let favorite: Bool
    let review: Review
    let superhost: Bool
}

struct Review: Codable {
    let rating: Double
    let count: Int
}
