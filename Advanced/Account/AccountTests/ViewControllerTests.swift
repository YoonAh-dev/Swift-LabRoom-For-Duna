//
//  ViewControllerTests.swift
//  AccountTests
//
//  Created by SHIN YOON AH on 2023/03/30.
//

import XCTest
@testable import Account

final class ViewControllerTests: XCTestCase {

    let viewController: ViewController = ViewController()
    let mockView: MockView = MockView()

    override func setUpWithError() throws {
        self.viewController.setAccountView(self.mockView)
        self.viewController.setAccountModel(AccountModel())
    }

    override func tearDownWithError() throws {

    }

    func testExample() throws { }

    func testPerformanceExample() throws {
        self.measure { }
    }

    func test_viewcontroller_트랜잭션요청을_잘처리하는가() {
        self.viewController.processTransactionRequest()
        XCTAssertEqual("$1.00", self.mockView.balance)
    }
}
