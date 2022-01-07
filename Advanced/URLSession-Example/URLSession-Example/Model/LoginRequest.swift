//
//  LoginRequest.swift
//  URLSession-Example
//
//  Created by SHIN YOON AH on 2022/01/07.
//

import Foundation

struct LoginRequest: Codable {
    var email: String
    var password: String
    
    init(email: String, password: String) {
        self.email = email
        self.password = password
    }
}
