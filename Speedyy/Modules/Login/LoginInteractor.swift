//
//  LoginInteractor.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation

protocol LoginInteractorProtocol {
    func loginUser(phoneNumber: LoginPhoneNumber, completion: @escaping (Result<Void, ApiError>) -> Void)
}

class LoginInteractor: LoginInteractorProtocol {
    var loginServiceManager: LoginServiceManagerProtocol?

    func loginUser(phoneNumber: LoginPhoneNumber, completion: @escaping (Result<Void, ApiError>) -> Void) {
        loginServiceManager?.loginUser(phoneNumber: phoneNumber) { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
