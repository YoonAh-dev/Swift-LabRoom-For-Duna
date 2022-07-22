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
    let officeHour: [String]
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case name
        case officeHour = "office_hour"
        case items
    }
    
    func getTodayOfficeHour() -> String? {
        let currentDate = Date.getCurrentDate(with: "E")
        
        switch currentDate {
        case "월":
            return officeHour[0]
        case "화":
            return officeHour[1]
        case "수":
            return officeHour[2]
        case "목":
            return officeHour[3]
        case "금":
            return officeHour[4]
        case "토":
            return officeHour[5]
        case "일":
            return officeHour[6]
        default:
            return nil
        }
    }
    
    func getOfficeRange() -> ClosedRange<Int> {
        let officeHours = getTodayOfficeHour()?.components(separatedBy: " - ")
        guard let startOfficeTime = officeHours?[0],
              let endOfficeTime = officeHours?[1] else { return 0...0 }
        let officeRange: ClosedRange = calculateTimeToInt(startOfficeTime)...calculateTimeToInt(endOfficeTime)
        
        return officeRange
    }
    
    private func calculateTimeToInt(_ time: String) -> Int {
        let times = time.components(separatedBy: ":")
        guard let hour = Int(times[0]),
              let minute = Int(times[1]) else { return 0 }
        
        return hour * 60 + minute
    }
}

struct Item: Codable {
    let id: Int
    let category, name: String
}
