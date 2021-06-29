//
//  LoginVM.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import Foundation
protocol TypicalView: AnyObject {
    func updateState()
}

class LoginVM {
    
    enum LoginState {
        case idle, loading, wrongUsername(String), wrongPassword(String), error(String)
    }
    
    var loginState: LoginState = .idle {
        didSet {
            loginView.updateState() // we can use RX for binding
        }
    }
    var loginResponse: LoginResponse?
    
    let userModel: UserModel
    let loginView: TypicalView
    init(userModel: UserModel, loginView: TypicalView) {
        self.userModel = userModel
        self.loginView = loginView
    }
    
    func login(userName: String, password: String) {
        userModel.login(username: userName, password: password) { [weak self] (result) in
            guard let self = self else { return }
            switch result {
            case .failure(let error):
                switch error {
                case .wrongPassword:
                    self.loginState = .wrongPassword("Please enter valid password")
                case .wrongUsername:
                    self.loginState = .wrongUsername("Please enter valid username")
                case .backendError(let message):
                    self.loginState = .error(message)
                }
                break
            case .success(let response):
                self.loginResponse = response
                self.loginState = .idle
            }
        }
    }
}

enum UserErrors: Error {
    case wrongPassword, wrongUsername, backendError(String)
}

class UserBusinessModel: UserModel {
    
    func isValidUsername(_ username: String) -> Bool {
        if !username.isEmpty {
            return true
        }
        return false
    }
    
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, UserErrors>) -> Void) {
        guard isValidUsername(username) else {
            completion(.failure(.wrongUsername))
            return
        }
        
        guard isValidPassword(password) else {
            completion(.failure(.wrongPassword))
            return
        }
        completion(.success(LoginResponse(token: "log in success token")))
    }
    
    func isValidPassword(_ password: String) -> Bool {
        if !password.isEmpty {
            return true
        }
        return false
    }
}

struct LoginResponse {
    let token: String?
}
