//
//  SearchTableViewCell.swift
//  Search-Logic-Test
//
//  Created by SHIN YOON AH on 2022/07/22.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    @IBOutlet weak var keywordLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func setKeywordLabel(with keyword: String) {
        keywordLabel.text = keyword
    }
    
    func setTimeLabel(with store: Store) {
        timeLabel.text = store.getOfficeHourState().title
        timeLabel.textColor = store.getOfficeHourState().titleColor
    }
}
