//
//  LikeRequest.swift
//  URLSession-Example
//
//  Created by SHIN YOON AH on 2022/01/07.
//

import Foundation

struct LikeRequest: Codable {
    var userId: Int
    var carId: Int
    var isLiked: Bool
    
    init(userId: Int, carId: Int, isLiked: Bool) {
        self.userId = userId
        self.carId = carId
        self.isLiked = isLiked
    }
}
