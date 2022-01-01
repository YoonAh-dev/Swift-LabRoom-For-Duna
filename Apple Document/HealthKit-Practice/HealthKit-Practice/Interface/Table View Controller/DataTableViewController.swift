//
//  DataTableViewController.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/11/09.
//

import UIKit

protocol HealthQueryDatasource: AnyObject {
    func performQuery(completion: @escaping () -> Void)
}

class DataTableViewController: UITableViewController {
    
    static let cellIdentifier = "DataTypeTableViewCell"
    
    let dateFormatter = DateFormatter()
    
    var dataTypeIdentifier: String
    var dataValues: [HealthDataTypeValue] = []
    
    public var showGroupedTableViewTitle: Bool = false
    
    // MARK: - Initalizers
    
    init(dataTypeIdentifier: String) {
        self.dataTypeIdentifier = dataTypeIdentifier
        super.init(style: .insetGrouped)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpNavigationController()
        setUpViewController()
        setUpTableView()
    }
    
    func setUpNavigationController() {
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func setUpViewController() {
        title = tabBarItem.title
        dateFormatter.dateStyle = .medium
    }
    
    func setUpTableView() {
        tableView.register(DataTypeTableViewCell.self, forCellReuseIdentifier: Self.cellIdentifier)
    }
    
    private var emptyDataView: EmptyDataBackgroundView {
        return EmptyDataBackgroundView(message: "No Data")
    }
    
    // MARK: - Data Life Cycle
    
    func reloadData() {
        self.dataValues.isEmpty ? self.setEmptyDataView() : self.removeEmptyDataView()
        self.dataValues.sort { $0.startDate > $1.startDate }
        self.tableView.reloadData()
        self.tableView.refreshControl?.endRefreshing()
    }
    
    private func setEmptyDataView() {
        tableView.backgroundView = emptyDataView
    }
    
    private func removeEmptyDataView() {
        tableView.backgroundView = nil
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataValues.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Self.cellIdentifier) as? DataTypeTableViewCell else {
            return DataTypeTableViewCell()
        }
        
        let dataValue = dataValues[indexPath.row]
        
        cell.textLabel?.text = formattedValue(dataValue.value, typeIdentifier: dataTypeIdentifier)
        cell.detailTextLabel?.text = dateFormatter.string(from: dataValue.startDate)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard
            let dataTypeTitle = getDataTypeName(for: dataTypeIdentifier),
            showGroupedTableViewTitle, !dataValues.isEmpty
        else {
            return nil
        }
        
        return String(format: "%@ %@", dataTypeTitle, "Samples")
    }
}
