//
//  MockView.swift
//  AccountTests
//
//  Created by SHIN YOON AH on 2023/03/30.
//

import Foundation
@testable import Account

final class MockView: AccountViewProtocol {

    // MARK: - property

    var balance: String?

    var withdrawalValue: String {
        return "10"
    }

    var depositValue: String {
        return "11"
    }

    // MARK: - method

    func setBalanceValue(balanceAmount: String) {
        self.balance = balanceAmount
    }

}
