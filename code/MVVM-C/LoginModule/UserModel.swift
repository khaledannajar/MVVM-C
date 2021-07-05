//
//  UserModel.swift
//  MVVM-C
//
//  Created by Khaled Annajar on 04/07/2021.
//

import Foundation

protocol UserModel: HasNetworkClient {
    func isValidPassword(_ password: String) -> Bool
    func isValidUsername(_ password: String) -> Bool
    func login(username: String, password: String, completion: @escaping (Result<Bool, UserErrors>)->Void ) // In the implementation we can save any session elated data
    func register(username: String, password: String, completion: @escaping (Result<Bool, UserErrors>)->Void )
    func sendOTP(_ otp: String, completion: @escaping (Result<Bool, UserErrors>)->Void )
}

class UserBusinessModel: UserModel {
 
    
    init(networkClient: NetworkClient = NetworkManager()) {
        self.networkClient = networkClient
    }
    
    let networkClient: NetworkClient
    
    private var loginResponse = LoginResponse(token: "log in success token")
    
    func isValidUsername(_ username: String) -> Bool {
        if !username.isEmpty {
            return true
        }
        return false
    }
    
    func login(username: String, password: String, completion: @escaping (Result<Bool, UserErrors>) -> Void) {
        guard isValidUsername(username) else {
            completion(.failure(.wrongUsername))
            return
        }
        
        guard isValidPassword(password) else {
            completion(.failure(.wrongPassword))
            return
        }
        networkClient.callBackend { result in
            if result.isEmpty {
                completion(.success(false))
            } else {
                completion(.success(true))
            }
        }
        
    }
    
    func isValidPassword(_ password: String) -> Bool {
        if !password.isEmpty {
            return true
        }
        return false
    }
    
    func register(username: String, password: String, completion: @escaping (Result<Bool, UserErrors>) -> Void) {
        networkClient.callBackend { token in
            if token.isEmpty {
                completion(.success(false))
            } else {
                completion(.success(true))
            }
        }
    }
    
    func sendOTP(_ otp: String, completion: @escaping (Result<Bool, UserErrors>) -> Void) {
        networkClient.callBackend { token in
            if token.isEmpty {
                completion(.success(false))
            } else {
                completion(.success(true))
            }
        }
    }
}

protocol NetworkClient {
    func callBackend(completion: @escaping (String) -> Void)
}
protocol HasNetworkClient {
    var networkClient: NetworkClient { get }
}
class NetworkManager: NetworkClient {
    func callBackend(completion: @escaping (String) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            completion("token")
        }
    }
}
