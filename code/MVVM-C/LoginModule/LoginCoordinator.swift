//
//  LoginCoordinator.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import UIKit

protocol HasUserModel {
    var userModel: UserModel { get }
}

protocol UserModel {
    func isValidPassword(_ password: String) -> Bool
    func isValidUsername(_ password: String) -> Bool
    func login(username: String, password: String, completion: @escaping (Result<LoginResponse, UserErrors>)->Void ) // In the implementation we can save any session elated data
}
class LoginCoordinator {
    typealias Dependencies = HasUserModel
    let dependencies: Dependencies
    let window: UIWindow
    init(window: UIWindow, dependencies: Dependencies) {
        self.window = window
        self.dependencies = dependencies
    }
    
    lazy var loginNav: UINavigationController = {
        let loginView = Controllers.getController(controllerKey: Controllers.login) as! LoginVC
        let loginVM = LoginVM(userModel: dependencies.userModel, loginView: loginView)
        loginView.loginVM = loginVM
        let nav = UINavigationController(rootViewController: loginView)
        return nav
    }()
    
    func start() {
        window.rootViewController = loginNav
    }
}

