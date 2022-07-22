//
//  StoreModel.swift
//  Search-Logic-Test
//
//  Created by SHIN YOON AH on 2022/07/22.
//

import Foundation

// MARK: - StoreModel
struct StoreModel: Codable {
    let data: [Store]
}

struct Store: Codable {
    let name: String
    let items: [Item]
}

struct Item: Codable {
    let id: Int
    let category, name: String
}
