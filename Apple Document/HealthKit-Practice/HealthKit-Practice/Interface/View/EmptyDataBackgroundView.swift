//
//  EmptyDataBackgroundView.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/11/09.
//

import UIKit

private extension CGFloat {
    static let horizontalInset: CGFloat = 60
}

class EmptyDataBackgroundView: UIView {

    var labelText: String!
    
    var label: UILabel = {
        let label = UILabel()
        
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .secondaryLabel
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 22, weight: .regular)
        label.numberOfLines = 0
        
        return label
    }()
    
    init(message: String) {
        self.labelText = message
        
        super.init(frame: .zero)
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(label)
        
        addConstraints()
    }
    
    func addConstraints() {
        var constraints: [NSLayoutConstraint] = []
        
        constraints += addLabelConstraints()
        
        NSLayoutConstraint.activate(constraints)
    }
    
    func addLabelConstraints() -> [NSLayoutConstraint] {
        return [
            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: .horizontalInset),
            label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -.horizontalInset),
            label.topAnchor.constraint(equalTo: topAnchor),
            label.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
    }
}
