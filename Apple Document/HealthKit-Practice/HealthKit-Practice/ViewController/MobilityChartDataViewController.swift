//
//  MobilityChartDataViewController.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/06.
//

import UIKit
import HealthKit

class MobilityChartDataViewController: DataTypeCollectionViewController {
    
    let calendar: Calendar = .current
    
    var mobilityContent: [String] = [
        HKQuantityTypeIdentifier.stepCount.rawValue,
        HKQuantityTypeIdentifier.distanceWalkingRunning.rawValue
    ]
    
    var queries: [HKAnchoredObjectQuery] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        data = mobilityContent.map { ($0, []) }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Authorization
        if !queries.isEmpty { return }
        
        HealthData.requestHealthDataAccessIfNeeded(dataTypes: mobilityContent) { success in
            if success {
                self.setUpBackgroundObservers()
                self.loadData()
            }
        }
    }
    
    // MARK: - Data Functions
    
    func setUpBackgroundObservers() {
        data.compactMap { getSampleType(for: $0.dataTypeIdentifier) }.forEach { sampleType in
            createAnchoredObjectQuery(for: sampleType)
        }
    }
    
    func loadData() {
        performQuery {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        }
    }
    
    func createAnchoredObjectQuery(for sampleType: HKSampleType) {
        let predicate = createLastWeekPredicate()
        let limit = HKObjectQueryNoLimit
        let anchor = HealthData.getAnchor(for: sampleType)
        
        let query = HKAnchoredObjectQuery(type: sampleType,
                                          predicate: predicate,
                                          anchor: anchor,
                                          limit: limit) {
            query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil in
            
            if let error = errorOrNil {
                print("HKAnchoredObjectQuery initalResultsHandler with identifier \(sampleType.identifier) error: \(error.localizedDescription)")
                
                return
            }
            
            print("HKAnchoredObjectQuery initalResultsHandler has returned for \(sampleType.identifier)!")
            
            HealthData.updateAnchor(newAnchor, from: query)
            Network.push(addedSamples: samplesOrNil, deletedSamples: deletedObjectsOrNil)
        }
        
        query.updateHandler = {
            query, samplesOrNil, deletedObjectsOrNil, newAnchor, errorOrNil in
            
            if let error = errorOrNil {
                print("HKAnchoredObjectQuery initialResultsHandler with identifier \(sampleType.identifier) error: \(error.localizedDescription)")
                
                return
            }
            
            print("HKAnchoredObjectQuery initalResult has returned for \(sampleType.identifier)!")
            
            HealthData.updateAnchor(newAnchor, from: query)
            Network.push(addedSamples: samplesOrNil, deletedSamples: deletedObjectsOrNil)
        }
        
        HealthData.healthStore.execute(query)
        queries.append(query)
    }
    
    // MARK: - Data Function
    func performQuery(completion: @escaping () -> Void) {
        for (index, item) in data.enumerated() {
            let now = Date()
            let startDate = getLastWeekStartDate()
            let endDate = now
            
            let predicate = createLastWeekPredicate()
            let dateInterval = DateComponents(day: 1)
            
            let statisticsOptions = getStatisticsOptions(for: item.dataTypeIdentifier)
            let initialResultHandler: (HKStatisticsCollection) -> Void = {
                statisticsCollection in
                var values: [Double] = []
                statisticsCollection.enumerateStatistics(from: startDate, to: endDate) {
                    statistics, stop in
                    let statisticsQuantity = getStatisticsQuantity(for: statistics, with: statisticsOptions)
                    if let unit = preferredUnit(for: item.dataTypeIdentifier),
                       let value = statisticsQuantity?.doubleValue(for: unit) {
                        values.append(value)
                    }
                }
                
                self.data[index].values = values
                
                completion()
            }
            
            HealthData.fetchStatistics(with: HKQuantityTypeIdentifier(rawValue: item.dataTypeIdentifier),
                                       predicate: predicate,
                                       options: statisticsOptions,
                                       startDate: startDate,
                                       interval: dateInterval,
                                       completion: initialResultHandler)
        }
    }
}
