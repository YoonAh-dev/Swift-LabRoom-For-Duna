//
//  UILabel+Extension.swift
//  ControlSentenceMovingWithTouch
//
//  Created by SHIN YOON AH on 2022/10/20.
//

import UIKit

extension UILabel {
    func applyColor(to targetString: String, with color: UIColor) {
        if let labelText = self.text, labelText.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(.foregroundColor,
                                       value: color,
                                       range: (labelText as NSString).range(of: targetString))
            attributedText = attributedString
        }
    }
}
