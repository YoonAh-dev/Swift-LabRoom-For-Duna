//
//  TextingViewController.swift
//  StackViewTest
//
//  Created by SHIN YOON AH on 4/27/25.
//

import SwiftUI
import UIKit
import SnapKit

final class TextingViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(TextingTableViewCell.self, forCellReuseIdentifier: TextingTableViewCell.identifier)
        tableView.dataSource = self
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
        
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
    }
}

extension TextingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell =  tableView.dequeueReusableCell(withIdentifier: TextingTableViewCell.identifier) as? TextingTableViewCell else { return UITableViewCell() }
        cell.configure()
        return cell
    }
}

extension UITableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

#Preview {
    TextingViewController()
}
