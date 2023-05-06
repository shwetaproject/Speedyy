//
//  LoginServiceManager.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import Foundation

protocol LoginServiceManagerProtocol {
    func loginUser(phoneNumber: LoginPhoneNumber, completion: @escaping (Result<Void, Error>) -> Void)
    func verifyLoginOtp(otp: VerifyOTP, completion: @escaping (Result<LoginOTPResult, Error>) -> Void)
}

class LoginServiceManager: LoginServiceManagerProtocol {

    private let service: ServiceManagerProtocol

    init(service: ServiceManagerProtocol = ServiceManager()) {
        self.service = service
    }

    func loginUser(phoneNumber: LoginPhoneNumber, completion: @escaping (Result<Void, Error>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/auth/login/otp"
        guard let url = URL(string: urlStr) else { return }

        do {
            let requestBody = try JSONEncoder().encode(phoneNumber)
            service.postApiData(requestUrl: url, requestBody: requestBody, resultType: EmptyData.self) { result in
                switch result {
                case .success(_):
                    completion(.success(()))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }

    func verifyLoginOtp(otp: VerifyOTP, completion: @escaping (Result<LoginOTPResult, Error>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/auth/login/verify"
        guard let url = URL(string: urlStr) else { return }

        do {
            let requestBody = try JSONEncoder().encode(otp)
            service.postApiData(requestUrl: url, requestBody: requestBody, resultType: LoginOTPResponse.self) { result in
                switch result {
                case .success(let loginResponse):
                    if let loginResult = loginResponse?.result {
                        completion(.success(loginResult))
                    }
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        } catch let error {
            completion(.failure(error))
        }
    }
}
