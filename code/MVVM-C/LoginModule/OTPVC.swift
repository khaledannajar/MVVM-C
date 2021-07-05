//
//  OTPVC.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import UIKit

class OTPVC: UIViewController {
    @IBOutlet weak var loadingView: UIActivityIndicatorView!
    @IBOutlet weak var tokenTextField: UITextField!
    
    var otpVM: OTPVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideLoading()
    }
    
    
    @IBAction func resendAction(_ sender: Any) {
//        otpVM.resend()
    }
    
    @IBAction func submitAction(_ sender: Any) {
        otpVM.submitOTP(tokenTextField.textOrEmpty)
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
