//
//  AccountModelProtocol.swift
//  Account
//
//  Created by SHIN YOON AH on 2023/03/30.
//

import Foundation

protocol AccountModelProtocol {
    func transact(deposit: Double, withdraw: Double) -> Double
}
