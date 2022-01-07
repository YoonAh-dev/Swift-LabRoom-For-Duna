//
//  Post.swift
//  URLSession-Example
//
//  Created by SHIN YOON AH on 2022/01/07.
//

struct Post: Codable {
    let id: Int
    let img: String
    let title, category: String
    let price: Int
    let state, trade, content: String
    let isDeleted: Bool
    let createdAt: String
    let userID: Int
    let address: String

    enum CodingKeys: String, CodingKey {
        case id, img, title, category, price, state, trade, content, isDeleted, createdAt
        case userID = "userId"
        case address
    }
}
