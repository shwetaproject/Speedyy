//
//  ProfileServiceManager.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import Foundation

protocol ProfileServiceManagerProtocol {
    func updateUserInfo(userInfo: UpdateUserInfo, userId: String, completion: @escaping (Result<Void, ApiError>) -> Void)
}

class ProfileServiceManager: ProfileServiceManagerProtocol {

    private let service: ServiceManagerProtocol

    init(service: ServiceManagerProtocol = ServiceManager()) {
        self.service = service
    }

    func updateUserInfo(userInfo: UpdateUserInfo, userId: String, completion: @escaping (Result<Void, ApiError>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/\(userId)"
        guard let url = URL(string: urlStr) else { return }

        do {
            let requestBody = try JSONEncoder().encode(userInfo)
            service.postApiData(requestUrl: url, requestBody: requestBody, resultType: EmptyData.self) { result in
                switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            let apiError = ApiError(code: 0, message: error.localizedDescription)
            completion(.failure(apiError))
        }
    }
}
