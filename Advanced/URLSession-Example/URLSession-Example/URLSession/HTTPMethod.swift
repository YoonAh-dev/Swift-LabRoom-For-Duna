//
//  HTTPMethod.swift
//  URLSession-Example
//
//  Created by SHIN YOON AH on 2022/01/07.
//

import Foundation

enum HTTPMethod<T> {
    case get
    case post(T)
    case put(T)
    case patch(T)
    case delete(T)
}

extension HTTPMethod {
    var method: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .put:
            return "PUT"
        case .patch:
            return "PATCH"
        case .delete:
            return "DELETE"
        }
    }
}
