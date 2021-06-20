//
//  CVC.swift
//  BSPhotoPicker
//
//  Created by SHIN YOON AH on 2021/06/20.
//

import UIKit

class CVC: UICollectionViewCell {
    var image = UIImageView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(image)
        image.translatesAutoresizingMaskIntoConstraints = false
        image.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor).isActive = true
        image.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor).isActive = true
        image.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor).isActive = true
        image.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        image.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3 - 10).isActive = true
        image.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width/3 - 10).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
