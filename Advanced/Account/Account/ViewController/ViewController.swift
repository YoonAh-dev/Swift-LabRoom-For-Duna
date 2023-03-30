//
//  ViewController.swift
//  Account
//
//  Created by SHIN YOON AH on 2023/03/30.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - ui component

    private let contentView = AccountView()

    // MARK: - property

    var accountView: AccountViewProtocol?
    var accountModel: AccountModelProtocol?

    // MARK: - life cycle

    override func loadView() {
        self.view = self.contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupView()
        self.setupModel()
        self.configureDelegation()
    }

    // MARK: - setup method

    fileprivate func setupView() {
        if let accountView = self.view as? AccountViewProtocol {
            self.setAccountView(accountView)
        }
    }

    fileprivate func setupModel() {
        if self.accountModel == nil {
            self.setAccountModel(AccountModel())
        }
    }

    private func configureDelegation() {
        self.contentView.configureDelegation(self)
    }

    // MARK: - setter method

    func setAccountView(_ accountView: AccountViewProtocol){
        self.accountView = accountView
    }

    func setAccountModel(_ accountModel: AccountModelProtocol){
        self.accountModel = accountModel
    }

    // MARK: - method

    func processTransactionRequest() {
        let depositString = self.accountView?.depositValue
        let withdrawalString = self.accountView?.withdrawalValue

        let deposit = self.getValue(depositString)
        let withdrawal = self.getValue(withdrawalString)
        let balance  = self.accountModel?.transact(deposit: deposit, withdraw: withdrawal)

        self.accountView?.setBalanceValue(balanceAmount: String(format: "$%.02f", balance ?? 0))
    }

    private func getValue(_ text: String?) -> Double {
        if let text = text {
            return Double(text) ?? 0
        }

        return 0
    }
}

// MARK: - AccountViewDelegate
extension ViewController: AccountViewDelegate {
    func submitButtonDidTap() {
        self.processTransactionRequest()
    }
}
