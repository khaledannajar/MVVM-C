//
//  MVVM_CTests.swift
//  MVVM-CTests
//
//  Created by khaledannajar on 5/17/21.
//

import XCTest
@testable import MVVM_C

class MVVM_CTests: XCTestCase {

  
    func testIsValidPassword() throws {
        
     let userModel = UserBusinessModel()
        XCTAssertFalse(userModel.isValidPassword(""))
        XCTAssertTrue(userModel.isValidPassword("1"))
        XCTAssertTrue(userModel.isValidPassword("a"))
        XCTAssertTrue(userModel.isValidPassword("@comLex^3Paawrodsw"))
    }

    func testIsPassword() throws {
        
     let userModel = UserBusinessModel()
        XCTAssertFalse(userModel.isValidUsername(""))
        XCTAssertTrue(userModel.isValidUsername("1"))
        XCTAssertTrue(userModel.isValidUsername("a"))
        XCTAssertTrue(userModel.isValidUsername("@comLex^3Paawrodsw"))
        
    }
    
    func test_wrong_userName_whatever_password() throws {
        let mockClient = NetworkClientMock()
        let userModel = UserBusinessModel(networkClient: mockClient)
        let expectation = XCTestExpectation()
        userModel.login(username: "", password: "password") { result in
            switch result {
            case .failure(let error):
                switch error {
                case .wrongUsername:
                    expectation.fulfill()
                default:
                    XCTFail("This should return wrong user name error")
                }
            case .success:
                XCTFail("This should fail and return wrong user name error.")
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func test_whatever_userName_wrong_password() throws {
        let mockClient = NetworkClientMock()
        let userModel = UserBusinessModel(networkClient: mockClient)
        let expectation = XCTestExpectation()
        userModel.login(username: "user name", password: "") { result in
            switch result {
            case .failure(let error):
                switch error {
                case .wrongPassword:
                    expectation.fulfill()
                default:
                    XCTFail("This should return wrong user name error")
                }
            case .success:
                XCTFail("This should fail and return wrong user name error.")
            }
        }
        wait(for: [expectation], timeout: 3.0)
    }
    
    func testLoginVM() {
        let mockClient = NetworkClientMock()
        let userModel = UserBusinessModel(networkClient: mockClient)
        let logInCoordinator = LoginCoordinatorMock()
        let vm = LoginVM(userModel: userModel, loginView: LoginMockView(), loginViewCoordinator: logInCoordinator)
        vm.register()
        XCTAssertTrue(logInCoordinator.registerCalledNumber == 1)
    }
    
}

class NetworkClientMock: NetworkClient {
    func callBackend(completion: @escaping (String) -> Void) {
        completion("dummy")
    }
}

class LoginMockView: TypicalView {
    func updateState() {
        
    }
}
class LoginCoordinatorMock: LoginViewCoordinator {
    private(set) var registerCalledNumber: Int = 0
    
    func needToRegister() {
        registerCalledNumber += 1
    }
    
    func needOTP() {
        
    }
    
    
}
