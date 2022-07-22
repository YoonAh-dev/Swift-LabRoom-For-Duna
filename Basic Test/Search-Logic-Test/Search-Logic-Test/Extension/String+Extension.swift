//
//  String+Extension.swift
//  Search-Logic-Test
//
//  Created by SHIN YOON AH on 2022/07/22.
//

import Foundation

extension String {
    func removingWhitespaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }
}
