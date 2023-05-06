//
//  UpdateProfile.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation

struct UpdateUserInfo: Codable {
    let full_name: String
    let alternate_phone: String
    let email: String
    let image_name: String?
}
