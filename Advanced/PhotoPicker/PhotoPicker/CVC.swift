//
//  CVC.swift
//  PhotoPicker
//
//  Created by SHIN YOON AH on 2021/06/19.
//

import UIKit

class CVC: UICollectionViewCell {
    var image = UIImageView()
    var number = UIButton()
    var didSelected = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addSubview(image)
        self.addSubview(number)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3).isActive = true
        image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3).isActive = true
        
        number.translatesAutoresizingMaskIntoConstraints = false
        number.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 10).isActive = true
        number.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -10).isActive = true
        number.heightAnchor.constraint(equalToConstant: 20).isActive = true
        number.widthAnchor.constraint(equalToConstant: 20).isActive = true
        
        number.layer.cornerRadius = 10
        number.backgroundColor = .systemPink
        number.titleLabel?.font = .systemFont(ofSize: 10, weight: .regular)
        number.setTitleColor(.white, for: .normal)
    }

}
