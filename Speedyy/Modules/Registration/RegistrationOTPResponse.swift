//
//  RegistrationOTPResponse.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import Foundation

struct RegistrationOTPResult: Codable {
    var alternate_phone: String?
    var email: String?
    var full_name: String?
    var id: String?
    var phone: String?
    var refresh_token: String?
    var token: String?
}

struct RegistrationOTPResponse: Decodable {
    let message: String?
    let result: RegistrationOTPResult?
    let status: Bool?
    let statusCode: Int?
}
