//
//  DataTypeTableViewCell.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/11/09.
//

import UIKit

class DataTypeTableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
