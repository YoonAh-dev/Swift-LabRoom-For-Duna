//
//  ServerResponse.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/05.
//

import Foundation

struct ServerResponse: Codable {
    let identifier: String
    var date: Date
    var weeklyReport: WeeklyReport
}

struct WeeklyReport: Codable {
    let identifier: String
    var startDate: Date
    var endDate: Date
    var samples: [ServerHealthSample]
}

struct ServerHealthSample: Codable {
    let syncIdentifier: String
    let syncVersion: Int
    let type: HealthSampleType
    let typeIdentifier: String
    let unit: String
    let value: Double
    var startDate: Date
    var endDate: Date
}

enum HealthSampleType: String, Codable {
    case category
    case quantity
}
