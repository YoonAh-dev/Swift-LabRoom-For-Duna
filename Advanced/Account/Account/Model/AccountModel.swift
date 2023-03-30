//
//  AccountModel.swift
//  Account
//
//  Created by SHIN YOON AH on 2023/03/30.
//

import Foundation

final class AccountModel: AccountModelProtocol {

    var balance:Double = 0

    func transact(deposit: Double, withdraw: Double) -> Double {
        balance += deposit
        balance -= withdraw
        return balance
    }
}
