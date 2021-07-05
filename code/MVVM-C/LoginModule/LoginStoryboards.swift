//
//  LoginStoryboards.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import UIKit


extension Storyboards {
    static let login = UIStoryboard(name: "Login", bundle: Bundle.main)
}

extension Controllers {
    static let login: ControllerKey = (Storyboards.login, "LoginVC")
    static let otp: ControllerKey = (Storyboards.login, "OTPVC")
    static let register: ControllerKey = (Storyboards.login, "RegisterVC")
    
}
