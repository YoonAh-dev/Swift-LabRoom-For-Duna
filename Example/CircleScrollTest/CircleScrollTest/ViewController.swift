//
//  ViewController.swift
//  CircleScrollTest
//
//  Created by SHIN YOON AH on 2021/06/29.
//

import UIKit

class ViewController: UIViewController {
    var tableView = UITableView()
    var headerView = CustomHeaderView(frame: CGRect.zero)
    var headerHeightConstraint: NSLayoutConstraint!
    var corner: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black
        setUpHeader()
        setUpTableView()
    }
    
    func setUpHeader() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(headerView)
        
        headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 496)
        headerHeightConstraint.isActive = true
        
        let constraints:[NSLayoutConstraint] = [
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }
    
    func setUpTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let constraints:[NSLayoutConstraint] = [
            tableView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension ViewController:UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y < 0 && self.headerHeightConstraint.constant < 496{
            self.headerHeightConstraint.constant += abs(scrollView.contentOffset.y)
            self.headerView.heightConstraint.constant += abs(scrollView.contentOffset.y)/2
            self.headerView.widthConstraint.constant += abs(scrollView.contentOffset.y)/2
            self.headerView.topConstraint.constant += abs(scrollView.contentOffset.y)/2
            
            self.headerView.backWidth.constant += abs(scrollView.contentOffset.y)*1.3
            self.headerView.backTop.constant -= abs(scrollView.contentOffset.y)/3
            
            if self.headerHeightConstraint.constant > 450 && self.headerView.colorView.layer.cornerRadius > 0 {
                self.headerView.colorView.layer.cornerRadius -= 50
            } else {
                let offset = self.headerView.backWidth.constant/2
                if offset < 50 {
                    self.headerView.colorView.layer.cornerRadius = 50
                } else {
                    self.headerView.colorView.layer.cornerRadius = offset
                }
            }
            
            if self.headerView.heightConstraint.constant > 116 {
                headerView.heightConstraint.constant = 116
            }
            
            if self.headerView.widthConstraint.constant > 135 {
                headerView.widthConstraint.constant = 135
            }
            
            if self.headerView.topConstraint.constant > 204 {
                headerView.topConstraint.constant = 204
            }
            
            if self.headerView.backWidth.constant > UIScreen.main.bounds.size.width {
                self.headerView.backWidth.constant = UIScreen.main.bounds.size.width
                self.headerView.colorView.layer.cornerRadius = 0
            }
            
            if self.headerView.backTop.constant < 0 {
                self.headerView.backTop.constant = 0
            }
            
        } else if scrollView.contentOffset.y > 0 && self.headerHeightConstraint.constant >= 199 {
            self.headerHeightConstraint.constant -= scrollView.contentOffset.y/15
            
            self.headerView.heightConstraint.constant -= scrollView.contentOffset.y/70
            self.headerView.widthConstraint.constant -= scrollView.contentOffset.y/70
            self.headerView.topConstraint.constant -= scrollView.contentOffset.y/50
        
            print(self.headerHeightConstraint.constant)
            if self.headerHeightConstraint.constant < 199 {
                self.headerHeightConstraint.constant = 199
                
                self.headerView.heightConstraint.constant = 58
                self.headerView.widthConstraint.constant = 67
                self.headerView.topConstraint.constant = 116
                
                self.headerView.backWidth.constant = 100
                self.headerView.backTop.constant = 95
                self.headerView.colorView.layer.cornerRadius = 50
            } else if self.headerHeightConstraint.constant < 490 {
                self.headerView.backWidth.constant -= scrollView.contentOffset.y/16
                self.headerView.backTop.constant += scrollView.contentOffset.y/50
                
                let offset = self.headerView.backWidth.constant/2
//                print(offset)
                if offset < 50 {
                    self.headerView.colorView.layer.cornerRadius = 50
                } else {
                    self.headerView.colorView.layer.cornerRadius = offset
                }
            } else {
                self.headerView.colorView.layer.cornerRadius += 10
            }
            
//            if self.headerView.colorView.layer.cornerRadius == self.headerHeightConstraint.constant/2 {
//                self.headerView.colorView.layer.cornerRadius = self.headerView.heightConstraint.constant/2
//            } else {
//                if self.headerView.colorView.layer.cornerRadius > 50 {
//                    self.headerView.colorView.layer.cornerRadius = 50
//                } else {
//
//                }
//
//            }
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if self.headerHeightConstraint.constant > 496 {
            animateHeader()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if self.headerHeightConstraint.constant > 496 {
            animateHeader()
        }
    }
    
    func animateHeader() {
        self.headerHeightConstraint.constant = 496
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.5, options: [], animations: {
            self.view.layoutIfNeeded()
            }, completion: nil)
    }
}

extension ViewController:UITableViewDelegate {
    
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = "Article \(indexPath.row)"
        return cell
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
}


