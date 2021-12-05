//
//  HealthQueryTableViewController.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/05.
//

import UIKit
import HealthKit
import CareKitUI

class HealthQueryTableViewController: ChartTableViewController, HealthQueryDatasource {
    
    var queryPredicate: NSPredicate? = nil
    var queryAnchor: HKQueryAnchor? = nil
    var queryLimit: Int = HKObjectQueryNoLimit
    
    // MARK: - View Life Cycle Overrides
    
    override func setUpViewController() {
        super.setUpViewController()
        
        setupFetchButton()
        setupRefreshControl()
    }
    
    private func setupFetchButton() {
        let barButtonItem = UIBarButtonItem(title: "Fetch",
                                            style: .plain,
                                            target: self,
                                            action: #selector(didTapFetchButton))
        navigationItem.rightBarButtonItem = barButtonItem
    }
    
    private func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        
        refreshControl.addTarget(self, action: #selector(refreshControlValueChanged), for: .valueChanged)
        
        self.refreshControl = refreshControl
    }
    
    // MARK: - Selectors
    
    @objc
    func didTapFetchButton() {
        fetchNetworkData()
    }
    
    @objc
    private func refreshControlValueChanged() {
        loadData()
    }
    
    // MARK: - Network
    
    func fetchNetworkData() {
        Network.pull() { [weak self] serverResponse in
            self?.handleServerResponse(serverResponse)
        }
    }
    
    func handleServerResponse(_ serverResponse: ServerResponse) {
        loadData()
    }
    
    // MARK: - HealthQueryDataSource
    
    func loadData() {
        performQuery {
            DispatchQueue.main.async { [weak self] in
                self?.reloadData()
            }
        }
    }
    
    func performQuery(completion: @escaping () -> Void) {
        guard let sampleType = getSampleType(for: dataTypeIdentifier) else { return }
        
        let anchoredObjectQuery = HKAnchoredObjectQuery(type: sampleType,
                                                        predicate: queryPredicate,
                                                        anchor: queryAnchor,
                                                        limit: queryLimit) {
            query, sampleOrNil, deletedObjectsOrNil, anchor, errorOrNil in
            
            guard let samples = sampleOrNil else { return }
            
            self.dataValues = samples.map { sample -> HealthDataTypeValue in
                var dataValue = HealthDataTypeValue(startDate: sample.startDate,
                                                    endDate: sample.endDate,
                                                    value: .zero)
                if let quantitySample = sample as? HKQuantitySample,
                   let unit = preferredUnit(for: quantitySample) {
                    dataValue.value = quantitySample.quantity.doubleValue(for: unit)
                }
                
                return dataValue
            }
            
            completion()
        }
        
        HealthData.healthStore.execute(anchoredObjectQuery)
    }
    
    // tableView data reloading 전에 chartview를 update
    override func reloadData() {
        DispatchQueue.main.async {
            self.chartView.applyDefaultConfiguration()
            
            let dateLastUpdated = Date()
            self.chartView.headerView.detailLabel.text = createChartDateLastUpdatedLabel(dateLastUpdated)
            self.chartView.headerView.titleLabel.text = getDataTypeName(for: self.dataTypeIdentifier)
            
            self.dataValues.sort { $0.startDate < $1.startDate }
            
            let sampleStartDates = self.dataValues.map { $0.startDate }
            
            self.chartView.graphView.horizontalAxisMarkers = createHorizontalAxisMarkers(for: sampleStartDates)
            
            let dataSeries = self.dataValues.compactMap { CGFloat($0.value) }
            guard
                let unit = preferredUnit(for: self.dataTypeIdentifier),
                let unitTitle = getUnitDescription(for: unit)
            else { return }
            
            self.chartView.graphView.dataSeries = [
                OCKDataSeries(values: dataSeries, title: unitTitle)
            ]
            
            self.view.layoutIfNeeded()
            
            super.reloadData()
        }
    }
    
}
