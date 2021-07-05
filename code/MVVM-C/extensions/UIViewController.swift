//
//  UIViewController.swift
//  MVVM-C
//
//  Created by Khaled Annajar on 05/07/2021.
//

import UIKit

extension UIViewController {
    
    func showAlert(
        title: String?,
        message: String?,
        agreeButtonName: String = "Ok", // localize this
        disagreeButtonNameIfAvailable: String? = nil,
        onAgreeAction: @escaping (UIAlertAction) -> () = { _ in }
    ) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: agreeButtonName, style: .default, handler: onAgreeAction)
        alertController.addAction(okAction)
        if let disagreeButtonName = disagreeButtonNameIfAvailable {
            let cancelAction = UIAlertAction(title: disagreeButtonName, style: .cancel, handler: nil)
            alertController.addAction(cancelAction)
        }
        self.present(alertController, animated: true, completion: nil)
    }
}
