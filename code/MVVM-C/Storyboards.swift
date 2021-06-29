//
//  Storyboards.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import UIKit

struct Storyboards {
}

extension Storyboards {
    static let main = UIStoryboard(name: "Main", bundle: Bundle.main)
}

struct Controllers {
    typealias ControllerKey = (storyboard: UIStoryboard, controllerName: String)
    
    static func getController(controllerKey: Controllers.ControllerKey) -> UIViewController? {
        return controllerKey.storyboard.instantiateViewController(withIdentifier: controllerKey.controllerName)
    }
}
 
extension Controllers {
    static let home: ControllerKey = (Storyboards.main, "ViewController")
    static let ViewController2: ControllerKey = (Storyboards.main, "ViewController2")
    
}
