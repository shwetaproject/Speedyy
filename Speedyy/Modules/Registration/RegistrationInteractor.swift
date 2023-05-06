//
//  RegistrationInteractor.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation

protocol RegistrationInteractorProtocol {
    func registerUser(userInfo: RegisterNewUser, completion: @escaping (Result<Void, ApiError>) -> Void)
}

class RegistrationInteractor: RegistrationInteractorProtocol {
    var registrationServiceManager: RegistrationServiceManager?

    func registerUser(userInfo: RegisterNewUser, completion: @escaping (Result<Void, ApiError>) -> Void) {
        registrationServiceManager?.registerUser(userInfo: userInfo, completion: { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
