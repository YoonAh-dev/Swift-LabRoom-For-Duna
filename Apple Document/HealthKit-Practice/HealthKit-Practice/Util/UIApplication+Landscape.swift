//
//  UIApplication+Landscape.swift
//  HealthKit-Practice
//
//  Created by SHIN YOON AH on 2021/12/06.
//

import UIKit

extension UIApplication {
    /// Returns whether the active window is in a landscape orientation.
    var isLandscape: Bool {
        return windows.first?.windowScene?.interfaceOrientation.isLandscape ?? false
    }
}

