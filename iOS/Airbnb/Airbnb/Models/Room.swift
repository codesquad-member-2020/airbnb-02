//
//  BNB.swift
//  Airbnb
//
//  Created by kimdo2297 on 2020/05/25.
//  Copyright © 2020 Chaewan Park. All rights reserved.
//

import Foundation

struct Room: Codable {
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
}

struct Coordinate: Codable {
    let latitude: Double
    let longitude: Double
}

struct Review: Codable {
    let rating: Double
    let count: Int
}

extension Room: Equatable { }

extension Coordinate: Equatable { }

extension Review: Equatable { }


