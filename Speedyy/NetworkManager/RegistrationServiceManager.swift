//
//  RegistrationServiceManager.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import Foundation

protocol RegistrationServiceManagerProtocol {
    func registerUser(userInfo: RegisterNewUser, completion: @escaping (Result<Void, ApiError>) -> Void)
    func verifyRegistrationOtp(otp: VerifyOTP, completion: @escaping (Result<RegistrationOTPResult, ApiError>) -> Void)
}

class RegistrationServiceManager: RegistrationServiceManagerProtocol {

    private let service: ServiceManagerProtocol

    init(service: ServiceManagerProtocol = ServiceManager()) {
        self.service = service
    }


    func registerUser(userInfo: RegisterNewUser, completion: @escaping (Result<Void, ApiError>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/auth/register/otp"
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

    func verifyRegistrationOtp(otp: VerifyOTP, completion: @escaping (Result<RegistrationOTPResult, ApiError>) -> Void) {
        let urlStr = "https://api.dev.speedyy.com/user/customer/auth/register/verify"
        guard let url = URL(string: urlStr) else { return }

        do {
            let requestBody = try JSONEncoder().encode(otp)
            service.postApiData(requestUrl: url, requestBody: requestBody, resultType: RegistrationOTPResponse.self) { result in
                switch result {
                case .success(let registrationResponse):
                    if let registrationResult = registrationResponse?.result {
                        completion(.success(registrationResult))
                    }
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
