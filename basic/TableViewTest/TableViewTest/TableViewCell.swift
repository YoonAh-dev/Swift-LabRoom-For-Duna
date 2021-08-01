//
//  TableViewCell.swift
//  TableViewTest
//
//  Created by SHIN YOON AH on 2021/07/25.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let identifier = "TableViewCell"

    @IBOutlet weak var tableView: UITableView!
    
    var lists: [String] = ["1", "2", "3", "4"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 130;
        
        tableView.register(UINib(nibName: "cell", bundle: nil), forCellReuseIdentifier: "cell")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension TableViewCell: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lists.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: "cell") as? cell else { return UITableViewCell() }
        return cell
    }
}

extension TableViewCell: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}
