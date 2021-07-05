//
//  LoginVC.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import UIKit

class LoginVC: UIViewController {

    var loginVM: LoginVM!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func registerAction(_ sender: Any) {
        loginVM.register()
    }
    
    @IBAction func loginAction(_ sender: Any) {
        loginVM.login(userName: userNameTextField.textOrEmpty, password: passwordTextField.textOrEmpty)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLoading()
    
    }
    func showLoading() {
        loadingView.startAnimating()
        loadingView.isHidden = false
    }
    
    func hideLoading() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }
    
}
//RX programming (RXswift, combine) Or
//manually binding

extension LoginVC: TypicalView {
    func updateState() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            
            switch self.loginVM.loginState {
            case .error(let message), .wrongUsername(let message), .wrongPassword(let message):
                self.hideLoading()
                self.showAlert(title: "Error", message: message)
            case .idle:
                self.hideLoading()
            case .loading:
                self.showLoading()
            }
        }
    }
}
