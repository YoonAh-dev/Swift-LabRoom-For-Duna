//
//  ChartTableViewController.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/05.
//

import UIKit
import CareKitUI
import HealthKit

private extension CGFloat {
    static let inset: CGFloat = 20
    static let itemSpacing: CGFloat = 12
    static let itemSpacingWithTitle: CGFloat = 0
}

class ChartTableViewController: DataTableViewController {
    
    // MARK: - UI Properties
    
    lazy var headerView: UIView = {
        let view = UIView()
        
        view.translatesAutoresizingMaskIntoConstraints = false
        
        return view
    }()
    
    lazy var chartView: OCKCartesianChartView = {
        let chartView = OCKCartesianChartView(type: .bar)
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.applyHeaderStyle()
        
        return chartView
    }()
    
    // MARK: - View Life Cycle Overrides
    
    override func updateViewConstraints() {
        chartViewBottomConstraint?.constant = showGroupedTableViewTitle ? .itemSpacingWithTitle : .itemSpacing
        
        super.updateViewConstraints()
    }
    
    override func setUpViewController() {
        super.setUpViewController()
        
        setupHeaderView()
        setupConstraints()
    }
    
    override func setUpTableView() {
        super.setUpTableView()
        
        showGroupedTableViewTitle = true
    }
    
    private func setupHeaderView() {
        headerView.addSubview(chartView)
        
        tableView.tableHeaderView = headerView
    }
    
    private func setupConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += createHeaderViewConstraints()
        constraints += createChartViewConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    private func createHeaderViewConstraints() -> [NSLayoutConstraint] {
        let leading = headerView.leadingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.leadingAnchor, constant: .inset)
        let trailing = headerView.trailingAnchor.constraint(equalTo: tableView.safeAreaLayoutGuide.trailingAnchor, constant: -.inset)
        let top = headerView.topAnchor.constraint(equalTo: tableView.topAnchor, constant: .itemSpacing)
        let centerX = headerView.centerXAnchor.constraint(equalTo: tableView.centerXAnchor)
        
        return [leading, trailing, top, centerX]
    }
    
    private var chartViewBottomConstraint: NSLayoutConstraint?
    private func createChartViewConstraints() -> [NSLayoutConstraint] {
        let leading = chartView.leadingAnchor.constraint(equalTo: headerView.leadingAnchor)
        let top = chartView.topAnchor.constraint(equalTo: headerView.topAnchor)
        let trailing = chartView.trailingAnchor.constraint(equalTo: headerView.trailingAnchor)
        let bottomConstant: CGFloat = showGroupedTableViewTitle ? .itemSpacingWithTitle : .itemSpacing
        let bottom = chartView.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -bottomConstant)
        
        chartViewBottomConstraint = bottom
        
        trailing.priority -= 1
        bottom.priority -= 1

        return [leading, top, trailing, bottom]
    }
}
