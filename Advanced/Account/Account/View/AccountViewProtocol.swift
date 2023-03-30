//
//  AccountViewProtocol.swift
//  Account
//
//  Created by SHIN YOON AH on 2023/03/30.
//

import Foundation

protocol AccountViewProtocol {
    var withdrawalValue: String { get }
    var depositValue: String { get }
    func setBalanceValue(balanceAmount: String)
}
