//
//  AccountTests.swift
//  AccountTests
//
//  Created by SHIN YOON AH on 2023/03/30.
//

import XCTest
@testable import Account

final class AccountTests: XCTestCase {

    var model: AccountModel?

    override func setUpWithError() throws {
        model = AccountModel()
    }

    override func tearDownWithError() throws {
        model = nil
    }

    func testExample() throws { }

    func testPerformanceExample() throws {
        self.measure { }
    }

    func test_account_입금_인출_금액이_제대로_반영되는가() {
        let result = model?.transact(deposit: 10, withdraw: 6)
        XCTAssertEqual(4, result)
    }
}


