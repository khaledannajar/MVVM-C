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
protocol LoginModuleParentCoordinator {
    func successfulLogin()
}
class LoginCoordinator {
    typealias Dependencies = HasUserModel
    let dependencies: Dependencies
    let window: UIWindow
    let parentCoordinator: LoginModuleParentCoordinator
    init(window: UIWindow, dependencies: Dependencies, parentCoordinator: LoginModuleParentCoordinator) {
        self.window = window
        self.dependencies = dependencies
        self.parentCoordinator = parentCoordinator
    }
    
    lazy var loginNav: UINavigationController = {
        let loginView = Controllers.getController(controllerKey: Controllers.login) as! LoginVC
        let loginVM = LoginVM(userModel: dependencies.userModel, loginView: loginView, loginViewCoordinator: self)
        loginView.loginVM = loginVM
        let nav = UINavigationController(rootViewController: loginView)
        return nav
    }()
    
    func start() {
        window.rootViewController = loginNav
    }
}

extension LoginCoordinator: LoginViewCoordinator {
    func needToRegister() {
        let registerView = Controllers.getController(controllerKey: Controllers.register) as! RegisterVC
        let registerVM = RegisterVM(userModel: dependencies.userModel, coordinator: self)
        registerView.registerVM = registerVM
        loginNav.pushViewController(registerView, animated: true)
    }
    
    func needOTP() {
        let otpView = Controllers.getController(controllerKey: Controllers.otp) as! OTPVC
        let otpVM = OTPVM(userModel: dependencies.userModel, coordinator: self)
        otpView.otpVM = otpVM
        loginNav.pushViewController(otpView, animated: true)
    }
    
    
}

extension LoginCoordinator: RegisterViewCoordinator {
    func neetToLogin() {
        loginNav.popViewController(animated: true)
    }
}

extension LoginCoordinator: OTPViewCoordinator {
    func finishedSuccessfully() {
        
    }
    
    
}
