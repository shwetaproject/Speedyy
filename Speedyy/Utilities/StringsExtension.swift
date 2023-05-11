//
//  StringsExtension.swift
//  Speedyy
//
//  Created by Shweta Talmale on 04/05/23.
//

import Foundation

extension String {
    func isValidPhoneNumber() -> Bool {
        guard self.count == 10,
              NSCharacterSet(charactersIn: "0123456789").isSuperset(of: NSCharacterSet(charactersIn: self) as CharacterSet) else {
            return false
        }
        return true
    }
}
