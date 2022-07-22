//
//  Date+Extension.swift
//  Search-Logic-Test
//
//  Created by SHIN YOON AH on 2022/07/22.
//

import Foundation

extension Date {
    static func getCurrentDate(with format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        let currentTimeString = formatter.string(from: Date())
        return currentTimeString
    }
}
