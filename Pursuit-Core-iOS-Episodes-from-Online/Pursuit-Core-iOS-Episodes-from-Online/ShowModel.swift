//
//  ShowModel.swift
//  Pursuit-Core-iOS-Episodes-from-Online
//
//  Created by Yuliia Engman on 12/13/19.
//  Copyright © 2019 Benjamin Stone. All rights reserved.
//

import Foundation

struct ShowSearch: Decodable {
    let show: Show
    let score: Double
}


struct Show: Decodable {
    let id: Int?
    let name: String?
    let rating: Rating?
    let image: Image?
}

struct Rating: Decodable {
    let average: Double?
}

struct Image: Decodable {
    let medium: String?
    let original: String?
}

