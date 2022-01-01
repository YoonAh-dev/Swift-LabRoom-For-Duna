//
//  WeeklyReportTableViewController.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/06.
//

import UIKit
import HealthKit

class WeeklyReportTableViewController: HealthQueryTableViewController {
    
    private var dateLastUpdated: Date?
    
    // MARK: - Initializers
    
    init() {
        super.init(dataTypeIdentifier: HKQuantityTypeIdentifier.sixMinuteWalkTestDistance.rawValue)
        
        queryPredicate = createLastWeekPredicate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle Overrides
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if !dataValues.isEmpty { return }
        
        HealthData.requestHealthDataAccessIfNeeded(dataTypes: [dataTypeIdentifier]) {
            success in
            if success {
                self.loadData()
            }
        }
    }
    
    // MARK: - Selector Overrides
    
    @objc
    override func didTapFetchButton() {
        Network.pull() { [weak self] serverResponse in
            self?.dateLastUpdated = serverResponse.date
            self?.queryPredicate = createLastWeekPredicate(from: serverResponse.date)
            self?.handleServerResponse(serverResponse)
        }
    }
    
    // MARK: - Network
    
    override func handleServerResponse(_ serverResponse: ServerResponse) {
        let weeklyReport = serverResponse.weeklyReport
        let addedSamples = weeklyReport.samples.map { ServerHealthSample -> HKQuantitySample in
            var metadata = [String: Any]()
            let sampleSyncIdentifier = String(format: "%@_%@", weeklyReport.identifier, ServerHealthSample.syncIdentifier)
            
            metadata[HKMetadataKeySyncIdentifier] = sampleSyncIdentifier
            metadata[HKMetadataKeySyncVersion] = ServerHealthSample.syncVersion
            
            let quantity = HKQuantity(unit: .meter(), doubleValue: ServerHealthSample.value)
            let sampleType = HKQuantityType.quantityType(forIdentifier: .sixMinuteWalkTestDistance)!
            let quantitySample = HKQuantitySample(type: sampleType,
                                                  quantity: quantity,
                                                  start: ServerHealthSample.startDate,
                                                  end: ServerHealthSample.endDate,
                                                  metadata: metadata)
            return quantitySample
        }
        
        HealthData.healthStore.save(addedSamples) { success, error in
            if success {
                self.loadData()
            }
        }
    }
    
    // MARK: - Function Overrides
    
    override func reloadData() {
        super.reloadData()
        
        DispatchQueue.main.async {
            self.chartView.graphView.horizontalAxisMarkers = createHorizontalAxisMarkers()
            
            if let dateLastUpdated = self.dateLastUpdated {
                self.chartView.headerView.detailLabel.text = createChartDateLastUpdatedLabel(dateLastUpdated)
            }
        }
    }
}
