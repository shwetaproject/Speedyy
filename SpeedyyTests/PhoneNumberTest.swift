//
//  PhoneNumberTest.swift
//  SpeedyyTests
//
//  Created by Shweta Talmale on 04/05/23.
//

import XCTest
@testable import Speedyy

final class PhoneNumberTest: XCTestCase {

    func testPhoneNumberLengthGreater() {
        let phoneNumber = "899392837386892"
        let isValidPhoneNumber = phoneNumber.isValidPhoneNumber()
        XCTAssertFalse(isValidPhoneNumber)
    }

    func testPhoneNumberLengthLess() {
        let phoneNumber = "98263783"
        let isValidPhoneNumber = phoneNumber.isValidPhoneNumber()
        XCTAssertFalse(isValidPhoneNumber)
    }

    func testPhoneNumberChar() {
        let phoneNumber = "9738462abd"
        let isValidPhoneNumber = phoneNumber.isValidPhoneNumber()
        XCTAssertFalse(isValidPhoneNumber)
    }

    func testPhoneNumberValid() {
        let phoneNumber = "9738462927"
        let isValidPhoneNumber = phoneNumber.isValidPhoneNumber()
        XCTAssertTrue(isValidPhoneNumber)
    }
}
