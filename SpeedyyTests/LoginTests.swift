//
//  LoginTests.swift
//  SpeedyyTests
//
//  Created by Shweta Talmale on 07/05/23.
//

import XCTest
@testable import Speedyy

final class LoginTests: XCTestCase {
    let loginInteractor = LoginInteractor()
    let exp = XCTestExpectation(description: "success")

    func testLoginUserNotExist() {
        loginInteractor.loginServiceManager = LoginServiceManager()
        let phoneNumber = LoginPhoneNumber(phone: "+919834728475")
        loginInteractor.loginUser(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, "User Does not Exist. Please Register.")
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testLoginUserInvalidNumber() {
        loginInteractor.loginServiceManager = LoginServiceManager()
        let phoneNumber = LoginPhoneNumber(phone: "9834728475")
        loginInteractor.loginUser(phoneNumber: phoneNumber) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, "\"phone\" failed custom validation because invalid.")
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testLoginUserSuccess() {
        loginInteractor.loginServiceManager = LoginServiceManager()
        let phoneNumber = LoginPhoneNumber(phone: "+917972243163")
        loginInteractor.loginUser(phoneNumber: phoneNumber) { [weak self] result in
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
