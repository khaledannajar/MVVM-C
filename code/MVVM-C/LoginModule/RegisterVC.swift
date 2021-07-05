//
//  RegisterVC.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import UIKit

class RegisterVC: UIViewController {

    var registerVM: RegisterVM!
    
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    func showLoading() {
        loadingView.startAnimating()
        loadingView.isHidden = false
    }
    
    func hideLoading() {
        loadingView.stopAnimating()
        loadingView.isHidden = true
    }

    @IBAction func registerTapped(_ sender: Any) {
        registerVM.registerMe(userNameTextField.textOrEmpty, password: passwordTextField.textOrEmpty)
    }
    
    @IBAction func goToLoginTapped(_ sender: Any) {
    }
}


extension RegisterVC: TypicalView {
    func updateState() {
        #warning("not implemented")
//        showLoading()
//        hideLoading()
    }
    
    
}
