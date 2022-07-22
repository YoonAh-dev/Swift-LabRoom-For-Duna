//
//  ViewController.swift
//  Search-Logic-Test
//
//  Created by SHIN YOON AH on 2022/07/22.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var timeLabel: UILabel!
    
    var storeData: [Store] = []
    var filteredStoreData: [Store] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setDelegation()
        setTableView()
        parseStoreData()
        compareBetweenCurrentAndOfficeHour()
    }
    
    private func setDelegation() {
        textField.delegate = self
        tableView.dataSource = self
    }
    
    private func setTableView() {
        let nib = UINib(nibName: "SearchTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "SearchTableViewCell")
    }
    
    private func parseStoreData() {
        let storeModel = MockParser.load(type: StoreModel.self, fileName: "Store")
        if let data = storeModel?.data {
            storeData = data
        }
    }
    
    private func compareBetweenCurrentAndOfficeHour() {
        let currentTime = calculateTime(Date.getCurrentDate(with: "HH:mm"))
        let officeHours = storeData[1].getTodayOfficeHour()?.components(separatedBy: " - ")
        guard let startOfficeTime = officeHours?[0],
              let endOfficeTime = officeHours?[1] else { return }
        let officeRange: ClosedRange = calculateTime(startOfficeTime)...calculateTime(endOfficeTime)
        
        if officeRange.contains(currentTime) {
            timeLabel.text = "영업 중"
        } else {
            timeLabel.text = "영업 종료"
        }
    }
    
    private func calculateTime(_ time: String) -> Int {
        let times = time.components(separatedBy: ":")
        guard let hour = Int(times[0]),
              let minute = Int(times[1]) else { return 0 }
        
        return hour * 60 + minute
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if let keyword = textField.text {
            filteredStoreData = storeData.filter({ data -> Bool in
                let storeNameFilter = data.name.lowercased().contains(keyword.lowercased())
                let itemNameFilter = data.items.map({ $0.name }).contains(where: { $0.contains(keyword.lowercased()) })
                let categoryFilter = data.items.map({ $0.category }).contains(where: { $0.contains(keyword.lowercased()) })
                return storeNameFilter || itemNameFilter || categoryFilter
            })
            tableView.reloadData()
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredStoreData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchTableViewCell", for: indexPath) as? SearchTableViewCell else { return UITableViewCell() }
        cell.setKeywordLabel(with: filteredStoreData[indexPath.row].name)
        return cell
    }
}
