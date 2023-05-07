//
//  RegistrationVerifyOTPTests.swift
//  SpeedyyTests
//
//  Created by Shweta Talmale on 07/05/23.
//

import XCTest
@testable import Speedyy

final class RegistrationVerifyOTPTests: XCTestCase {
    let verifyOTPInteractor = VerifyOTPInteractor()
    let exp = XCTestExpectation(description: "success")
    let otpLengthErr = "\"otp\" length must be less than or equal to 5 characters long"
    let invalidOtpMsg = "Invalid OTP"
    let invalidPhnMsg = "\"phone\" failed custom validation because invalid."
    let phoneLengthErr = "\"phone\" length must be less than or equal to 13 characters long"

    func testLoginOTPLength() {
        verifyOTPInteractor.registerServiceManager = RegistrationServiceManager()

        let otp = VerifyOTP(phone: "+917972243163", otp: "000000")
        verifyOTPInteractor.verifyRegistrationOtp(otp: otp) { [weak self] result in
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
        verifyOTPInteractor.registerServiceManager = RegistrationServiceManager()

        let otp = VerifyOTP(phone: "+917972243163", otp: "01746")
        verifyOTPInteractor.verifyRegistrationOtp(otp: otp) { [weak self] result in
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
        verifyOTPInteractor.registerServiceManager = RegistrationServiceManager()

        let otp = VerifyOTP(phone: "17972243163", otp: "01746")
        verifyOTPInteractor.verifyRegistrationOtp(otp: otp) { [weak self] result in
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
        verifyOTPInteractor.registerServiceManager = RegistrationServiceManager()

        let otp = VerifyOTP(phone: "+913437972243163", otp: "01746")
        verifyOTPInteractor.verifyRegistrationOtp(otp: otp) { [weak self] result in
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
}
