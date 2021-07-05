//
//  RegisterVM.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import Foundation
protocol RegisterViewCoordinator {
    func neetToLogin()
    func needOTP()
}

class RegisterVM {
    let userModel: UserModel
    let coordinator: RegisterViewCoordinator
    var view: TypicalView?
    
    init(userModel: UserModel, coordinator: RegisterViewCoordinator) {
        self.userModel = userModel
        self.coordinator = coordinator
    }
    
    func registerMe( _ userName: String, password: String) {
        userModel.register(username: userName, password: password) { result in
            switch result {
            case .failure(let error):
//                set state to error with message
                break
            case .success(let registered):
                if registered {
                    // set state
                } else {
                    // set state
                }
            }
        }
    }
    
    func goToLogin() {
        coordinator.neetToLogin()
    }
    
}
