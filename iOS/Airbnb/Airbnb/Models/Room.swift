//
//  BNB.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct Room: Codable, Equatable {
    let id: Int
    let title: String
    let type: String
    let location: String
    let coordinate: Coordinate
    let images: [String]
    let price: Int
    let favorite: Bool
    let review: Review
    let superhost: Bool
    
    func repeatImages(handler: (String) -> ()) {
        images.forEach { handler($0) }
    }
}

struct Coordinate: Codable, Equatable {
    let latitude: Double
    let longitude: Double
}

struct Review: Codable, Equatable {
    let rating: Double
    let count: Int
}
