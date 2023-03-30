//
//  AccountView.swift
//  Account
//
//  Created by SHIN YOON AH on 2023/03/30.
//

import UIKit

protocol AccountViewDelegate: AnyObject {
    func submitButtonDidTap()
}

final class AccountView: UIView, AccountViewProtocol {

    // MARK: - ui component

    private let balanceTitleLabel: UILabel = UILabel()
    private let withdrawalTitleLabel: UILabel = UILabel()
    private let depositTitleLabel: UILabel = UILabel()
    private let balanceValueLabel: UILabel = UILabel()
    private let withdrawalValueTextField: UITextField = UITextField()
    private let depositValueTextField: UITextField = UITextField()
    private let submitButton: UIButton = UIButton(type: .system)

    // MARK: - property

    private weak var delegate: AccountViewDelegate?

    var withdrawalValue: String {
        return self.withdrawalValueTextField.text ?? ""
    }
    var depositValue: String {
        return self.depositValueTextField.text ?? ""
    }

    // MARK: - init

    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupLayout()
        self.configureUI()
        self.setupButtonAction()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - func

    private func setupLayout() {
        [self.balanceTitleLabel, self.withdrawalTitleLabel, self.depositTitleLabel, self.balanceValueLabel, self.withdrawalValueTextField, self.depositValueTextField, self.submitButton].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }

        NSLayoutConstraint.activate([
            self.balanceTitleLabel.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.balanceTitleLabel.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.balanceValueLabel.topAnchor.constraint(equalTo: self.balanceTitleLabel.bottomAnchor, constant: 10),
            self.balanceValueLabel.leadingAnchor.constraint(equalTo: self.balanceTitleLabel.leadingAnchor),
            self.depositTitleLabel.topAnchor.constraint(equalTo: self.balanceValueLabel.bottomAnchor, constant: 20),
            self.depositTitleLabel.leadingAnchor.constraint(equalTo: self.balanceTitleLabel.leadingAnchor),
            self.depositValueTextField.topAnchor.constraint(equalTo: self.depositTitleLabel.bottomAnchor, constant: 5),
            self.depositValueTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.depositValueTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.depositValueTextField.heightAnchor.constraint(equalToConstant: 30),
            self.withdrawalTitleLabel.topAnchor.constraint(equalTo: self.depositValueTextField.bottomAnchor, constant: 10),
            self.withdrawalTitleLabel.leadingAnchor.constraint(equalTo: self.balanceTitleLabel.leadingAnchor),
            self.withdrawalValueTextField.topAnchor.constraint(equalTo: self.withdrawalTitleLabel.bottomAnchor, constant: 5),
            self.withdrawalValueTextField.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            self.withdrawalValueTextField.trailingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            self.withdrawalValueTextField.heightAnchor.constraint(equalToConstant: 30),
            self.submitButton.topAnchor.constraint(equalTo: self.withdrawalValueTextField.bottomAnchor, constant: 30),
            self.submitButton.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }

    private func configureUI() {
        self.backgroundColor = .white

        self.balanceTitleLabel.text = "balance"
        self.balanceValueLabel.text = "$0"
        self.depositTitleLabel.text = "deposit"
        self.withdrawalTitleLabel.text = "withdrawal"
        self.submitButton.setTitle("submit", for: .normal)

        self.balanceValueLabel.font = .systemFont(ofSize: 30)

        self.depositValueTextField.borderStyle = .bezel
        self.withdrawalValueTextField.borderStyle = .bezel
    }

    private func setupButtonAction() {
        let submitAction = UIAction { [weak self] _ in
            self?.delegate?.submitButtonDidTap()
        }
        self.submitButton.addAction(submitAction, for: .touchUpInside)
    }

    func configureDelegation(_ delegate: AccountViewDelegate) {
        self.delegate = delegate
    }

    func setBalanceValue(balanceAmount: String) {
        self.balanceValueLabel.text = balanceAmount
    }
}
