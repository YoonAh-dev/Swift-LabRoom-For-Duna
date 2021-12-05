//
//  CareKitSupport.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/06.
//

import Foundation
import CareKitUI

// MARK: - Chart Date UI

private func createMonthDayDateFormatter() -> DateFormatter {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "MM/dd"
    
    return dateFormatter
}

func createChartDateLastUpdatedLabel(_ dateLastUpdated: Date) -> String {
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateStyle = .medium
    
    return "last updated on \(dateFormatter.string(from: dateLastUpdated))"
}

func createHorizontalAxisMarkers(for dates: [Date]) -> [String] {
    let dateFormatter = createMonthDayDateFormatter()
    
    return dates.map { dateFormatter.string(from: $0) }
}
