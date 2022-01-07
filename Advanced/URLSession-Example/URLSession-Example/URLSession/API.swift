//
//  API.swift
//  URLSession-Example
//
//  Created by SHIN YOON AH on 2022/01/07.
//

import Foundation

class API {
    // ERROR Setting
    enum APIError: LocalizedError {
        case urlNotSupport
        case noData
        
        var errorDescription: String? {
            switch self {
            case .urlNotSupport:
                return "URL NOT Supported"
            case .noData:
                return "Has No Data"
            }
        }
    }
    
    // Singleton 방식으로 관리
    static let shared: API = API()
    
    private lazy var defaultSession = URLSession(configuration: .default)
    
    private init() { }
    
    // Resource를 생성함과 동시에 parse할 decodable Type에 해당하는 타입을 정해주고, 정해진 init방식에 따라 url, method를 전달해주도록 합니다.
    // 이후 load 함수를 통하여 값을 가져옵니다.
    func getPost(completionHandler: @escaping (Result<[Post], APIError>) -> Void) {
        guard let url = URL(string: "\(GenericAPI.daangnURL)/post") else { completionHandler(.failure(.urlNotSupport))
            return
        }
        let resource = Resource<GenericArrayResponse<Post>>(url: url)
        
        defaultSession.load(resource) { userDatas, _ in
            guard let data = userDatas?.data, !data.isEmpty else {
                completionHandler(.failure(.noData))
                return
            }
            
            completionHandler(.success(data))
        }
    }
    
    func getSearchPost(search: String, completionHandler: @escaping (Result<[Post], APIError>) -> Void) {
        let resource = Resource<GenericArrayResponse<Post>>(url: "\(GenericAPI.daangnURL)/post/search", parameters: ["keyword": search])
        
        defaultSession.load(resource) { userDatas, _ in
            guard let data = userDatas?.data, !data.isEmpty else {
                completionHandler(.failure(.noData))
                return
            }
            
            completionHandler(.success(data))
        }
    }
    
    func postLogin(email: String, password: String,
                   completionHandler: @escaping (Result<Token, APIError>) -> Void) {
        guard let url = URL(string: "\(GenericAPI.daangnURL)/user/login") else {
            completionHandler(.failure(.urlNotSupport))
            return
        }
        let loginData = LoginRequest(email: email, password: password)
        let resource = Resource<Token>(url: url, method: .post(loginData))
        
        defaultSession.load(resource) { userData, _ in
            guard let data = userData else {
                completionHandler(.failure(.noData))
                return
            }
            
            completionHandler(.success(data))
        }
    }
    
    func putLike(userId: Int,
             carId: Int,
             isLiked: Bool,
             completionHandler: @escaping (Result<Like, APIError>) -> Void) {
        guard let url = URL(string: "\(GenericAPI.socarURL)/my/favorite") else {
            completionHandler(.failure(.urlNotSupport))
            return
        }
        let likeData = LikeRequest(userId: userId, carId: carId, isLiked: isLiked)
        let resource = Resource<Like>(url: url, method: .put(likeData))
        
        defaultSession.load(resource) { userData, _ in
            guard let data = userData else {
                completionHandler(.failure(.noData))
                return
            }
            
            completionHandler(.success(data))
        }
    }
    
    func patchLike(completionHandler: @escaping (Result<Like, APIError>) -> Void) {
        guard let url = URL(string: "\(GenericAPI.naverURL)/post") else {
            completionHandler(.failure(.urlNotSupport))
            return
        }
        let likeData = LikeRequest(userId: 1, carId: 1, isLiked: true)
        let resource = Resource<Like>(url: url, method: .patch(likeData))
        
        defaultSession.load(resource) { userData, _ in
            guard let data = userData else {
                completionHandler(.failure(.noData))
                return
            }
            
            completionHandler(.success(data))
        }
    }
    
    func delete(completionHandler: @escaping (Result<Like, APIError>) -> Void) {
        guard let url = URL(string: "\(GenericAPI.naverURL)/post") else {
            completionHandler(.failure(.urlNotSupport))
            return
        }
        let userData = LikeRequest(userId: 1, carId: 1, isLiked: true)
        let resource = Resource<Like>(url: url, method: .delete(userData))
        
        defaultSession.load(resource) { userData, response in
            guard let userData = userData else {
                completionHandler(.failure(.noData))
                return
            }

            completionHandler(.success(userData))
        }
    }
}
