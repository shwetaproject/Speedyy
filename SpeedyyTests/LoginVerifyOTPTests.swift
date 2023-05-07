//
//  LoginVerifyOTPTests.swift
//  SpeedyyTests
//
//  Created by Shweta Talmale on 07/05/23.
//

import XCTest
@testable import Speedyy

final class LoginVerifyOTPTests: XCTestCase {
    let verifyOTPInteractor = VerifyOTPInteractor()
    let exp = XCTestExpectation(description: "success")
    let otpLengthErr = "\"otp\" length must be less than or equal to 5 characters long"
    let invalidOtpMsg = "Incorrect OTP"
    let invalidPhnMsg = "\"phone\" failed custom validation because invalid."
    let phoneLengthErr = "\"phone\" length must be less than or equal to 13 characters long"
    let incorrectCredentialsErr = "Incorrect Credentials"

    func testLoginOTPLength() {
        verifyOTPInteractor.loginServiceManager = LoginServiceManager()

        let otp = VerifyOTP(phone: "+917972243163", otp: "000000")
        verifyOTPInteractor.verifyLoginOtp(otp: otp) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, self?.otpLengthErr)
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testLoginOTPInvalid() {
        verifyOTPInteractor.loginServiceManager = LoginServiceManager()

        let otp = VerifyOTP(phone: "+917972243163", otp: "01746")
        verifyOTPInteractor.verifyLoginOtp(otp: otp) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, self?.invalidOtpMsg)
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testLoginInvalidPhone() {
        verifyOTPInteractor.loginServiceManager = LoginServiceManager()

        let otp = VerifyOTP(phone: "17972243163", otp: "01746")
        verifyOTPInteractor.verifyLoginOtp(otp: otp) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, self?.invalidPhnMsg)
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testLoginInvalidPhoneLength() {
        verifyOTPInteractor.loginServiceManager = LoginServiceManager()

        let otp = VerifyOTP(phone: "+913437972243163", otp: "01746")
        verifyOTPInteractor.verifyLoginOtp(otp: otp) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, self?.phoneLengthErr)
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }

    func testInvalidLoginUser() {
        verifyOTPInteractor.loginServiceManager = LoginServiceManager()

        let otp = VerifyOTP(phone: "+919736529737", otp: "00000")
        verifyOTPInteractor.verifyLoginOtp(otp: otp) { [weak self] result in
            switch result {
            case .failure(let error):
                XCTAssertEqual(error.message, self?.incorrectCredentialsErr)
                XCTAssertEqual(error.code, 0)
                self?.exp.fulfill()
            default:
                break
            }
        }
        wait(for: [exp], timeout: 10)
    }
}
