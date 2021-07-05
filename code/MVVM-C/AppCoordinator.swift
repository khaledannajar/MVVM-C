//
//  AppCoordinator.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import UIKit

class AppCoordinator {
    
    private var tabbarCoordinatgor: TabbarCoordinator?
    private var loginCoordinator: LoginCoordinator?
    
    let window: UIWindow
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
        print("app coordinator")
        loginCoordinator = LoginCoordinator(window: window, dependencies: BeforeLoginDependencies(), parentCoordinator: self)
        loginCoordinator!.start()
        self.window.makeKeyAndVisible()
    }
    
}

extension AppCoordinator: LoginModuleParentCoordinator {
    func successfulLogin() {
        tabbarCoordinatgor = TabbarCoordinator(window: window)
        tabbarCoordinatgor?.start()
        loginCoordinator = nil // freeing the memory
    }
}

class TabbarCoordinator {
    let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func start() {
//        create tab bar controller, add tabs, and thier view models and set the tabbarcontroller to the rootViewController of the window
    }
}
