//
//  ProfileInteractor.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation
 
protocol ProfileInteractorProtocol {
    func updateUserInfo(userInfo: UpdateUserInfo, userId: String, completion: @escaping (Result<Void, ApiError>) -> Void)
}

class ProfileInteractor: ProfileInteractorProtocol {
    var profileServiceManager: ProfileServiceManagerProtocol?

    func updateUserInfo(userInfo: UpdateUserInfo, userId: String, completion: @escaping (Result<Void, ApiError>) -> Void) {
        profileServiceManager?.updateUserInfo(userInfo: userInfo, userId: userId, completion: { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
