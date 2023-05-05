//
//  LoginOTPResponse.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import Foundation

struct LoginOTPResult: Codable {
    var alternate_phone: String?
    var email: String?
    var full_name: String?
    var id: String?
    var image_bucket: String?
    var image_path: String?
    var image_url: String?
    var phone: String?
    var refresh_token: String?
    var token: String?
}

struct LoginOTPResponse: Decodable {
    let message: String?
    let result: LoginOTPResult?
    let status: Bool?
    let statusCode: Int?
}
