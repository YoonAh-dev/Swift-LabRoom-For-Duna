//
//  ChartViewStyle.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/05.
//

import UIKit
import CareKitUI

extension OCKCartesianChartView {
    func applyDefaultConfiguration() {
        applyDefaultStyle()
        
        let numberFormatter = NumberFormatter()
        
        numberFormatter.numberStyle = .none
        
        graphView.numberFormatter = numberFormatter
        graphView.yMinimum = 0
    }
    
    func applyDefaultStyle() {
        headerView.detailLabel.textColor = .secondaryLabel
    }
    
    func applyHeaderStyle() {
        applyDefaultStyle()
        
        customStyle = ChartHeaderStyle()
    }
}

struct ChartHeaderStyle: OCKStyler {
    var appearance: OCKAppearanceStyler {
        NoShadowAppearanceStyle()
    }
}

struct NoShadowAppearanceStyle: OCKAppearanceStyler {
    var shadowOpacity1: Float = 0
    var shadowRadius1: CGFloat = 0
    var shadowOffset1: CGSize = .zero
}
