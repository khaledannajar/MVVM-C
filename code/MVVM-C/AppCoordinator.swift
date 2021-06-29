//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import UIKit

class AppCoordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        print("app coordinator")
        let controller = Controllers.getController(controllerKey: Controllers.ViewController2)
        self.window.rootViewController = controller
        self.window.makeKeyAndVisible()
    }
    
}
