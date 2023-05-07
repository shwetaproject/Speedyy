//
//  RegistrationTests.swift
//  SpeedyyTests
//
//  Created by Shweta Talmale on 07/05/23.
//

import XCTest
@testable import Speedyy

final class RegistrationTests: XCTestCase {
    let registrationInteractor = RegistrationInteractor()
    let exp = XCTestExpectation(description: "success")
    let emailErrMsg = "\"email\" must be a valid email"
    let phoneErrMsg = "\"phone\" failed custom validation because invalid."
    let phoneAlreadyExist = "Phone already exists, Please login"

    func testRegisterUserInvalidEmail() {
        registrationInteractor.registrationServiceManager = RegistrationServiceManager()

        let userInfo = RegisterNewUser(full_name: "ABCD", phone: "9473847284", email: "abcd")
        registrationInteractor.registerUser(userInfo: userInfo) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, self?.emailErrMsg)
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testRegisterUserInvalidNumber() {
        registrationInteractor.registrationServiceManager = RegistrationServiceManager()

        let userInfo = RegisterNewUser(full_name: "ABCD", phone: "9473847284", email: "abcd@gmail.com")
        registrationInteractor.registerUser(userInfo: userInfo) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, self?.phoneErrMsg)
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testRegisterUserAlreadyExist() {
        registrationInteractor.registrationServiceManager = RegistrationServiceManager()

        let userInfo = RegisterNewUser(full_name: "ABCD", phone: "+917972243163", email: "abcd@gmail.com")
        registrationInteractor.registerUser(userInfo: userInfo) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, self?.phoneAlreadyExist)
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testRegisterUserSuccess() {
        registrationInteractor.registrationServiceManager = RegistrationServiceManager()

        let userInfo = RegisterNewUser(full_name: "ABCD", phone: "+917483742834", email: "abcd@gmail.com")
        registrationInteractor.registerUser(userInfo: userInfo) { [weak self] result in
            switch result {
            case .success():
                XCTAssert(true)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }
}
