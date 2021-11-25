//
//  HealthKitSupport+String.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/11/09.
//

import Foundation
import HealthKit

// MARK: - Data Type Strings

func getDataTypeName(for identifier: String) -> String? {
    var description: String?
    let sampleType = getSampleType(for: identifier)
    
    if sampleType is HKQuantityType {
        let quantityTypeIdentifier = HKQuantityTypeIdentifier(rawValue: identifier)
        
        switch quantityTypeIdentifier {
        case .stepCount:
            description = "Step Count"
        case .distanceWalkingRunning:
            description = "Distance Walking + Running"
        case .sixMinuteWalkTestDistance:
            description = "Six-Minute Walk"
        default:
            break
        }
    }
    
    return description
}

// MARK: - Formatted Value Strings

func formattedValue(_ value: Double, typeIdentifier: String) -> String? {
    guard
        let unit = preferredUnit(for: typeIdentifier),
        let roundedValue = getRoundedValue(for: value, with: unit),
        let unitSuffix = getUnitSuffix(for: unit)
    else {
        return nil
    }
    
    let formattedString = String.localizedStringWithFormat("%@ %@", roundedValue, unitSuffix)
    
    return formattedString
}

private func getRoundedValue(for value: Double, with unit: HKUnit) -> String? {
    let numberFormatter = NumberFormatter()
    
    numberFormatter.numberStyle = .decimal
    
    switch unit {
    case .count(), .meter():
        let numberValue = NSNumber(value: round(value))
        return numberFormatter.string(from: numberValue)
    default:
        return nil
    }
}

// MARK: - Unit Strings

func getUnitDescription(for unit: HKUnit) -> String? {
    switch unit {
    case .count():
        return "steps"
    case .meter():
        return "meters"
    default:
        return nil
    }
}

func getUnitSuffix(for unit: HKUnit) -> String? {
    switch unit {
    case .count():
        return "steps"
    case .meter():
        return "m"
    default:
        return nil
    }
}
