//
//  RegisterNewUser.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import Foundation

struct RegisterNewUser: Codable {
    let full_name: String
    let phone: String
    let email: String
}

struct UpdateUserInfo: Codable {
    let full_name: String
    let alternate_phone: String
    let email: String
    let image_name: String?
}
