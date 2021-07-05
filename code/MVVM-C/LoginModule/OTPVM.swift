//
//  OTPVM.swift
//  MVVM-C
//
//  Created by khaledannajar on 5/17/21.
//

import Foundation

protocol OTPViewCoordinator {
    func finishedSuccessfully()
}
class OTPVM {
    let userModel: UserModel
    let coordinator: OTPViewCoordinator
    var view: TypicalView?
    enum OTPState {
        case success, loading, idle, error(String)
    }
    var state: OTPState = .idle {
        didSet {
            view?.updateState()
        }
    }
    
    init(userModel: UserModel, coordinator: OTPViewCoordinator) {
        self.userModel = userModel
        self.coordinator = coordinator
    }
    
    func submitOTP(_ otp: String) {
        state = .loading
        userModel.sendOTP(otp) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .failure(let error):
                self.state = .error(error.localizedDescription)
                break
            case .success:
                self.state = .success
                self.coordinator.finishedSuccessfully()
            break
            }
        }
    }
}
