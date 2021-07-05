//
//  LoginVM.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import Foundation

protocol LoginViewCoordinator {
    func needToRegister()
    func needOTP()
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
    let loginViewCoordinator: LoginViewCoordinator
    init(userModel: UserModel, loginView: TypicalView, loginViewCoordinator: LoginViewCoordinator) {
        self.userModel = userModel
        self.loginView = loginView
        self.loginViewCoordinator = loginViewCoordinator
    }
    
    func login(userName: String, password: String) {
        if case LoginState.loading = loginState {
            return
        }
        self.loginState = .loading
        
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
            case .success:
                self.loginState = .idle
                self.loginViewCoordinator.needOTP()
            }
        }
    }
    
    func register() {
        loginViewCoordinator.needToRegister()
    }
    
}

enum UserErrors: Error {
    case wrongPassword, wrongUsername, backendError(String)
}

struct LoginResponse {
    let token: String?
}
