//
//  VerifyOTPInteractor.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation

protocol VerifyOTPInteractorProtocol {
    func verifyLoginOtp(otp: VerifyOTP, completion: @escaping (Result<LoginOTPResult, ApiError>) -> Void)
    func verifyRegistrationOtp(otp: VerifyOTP, completion: @escaping (Result<RegistrationOTPResult, ApiError>) -> Void)
    func loginUser(phoneNumber: LoginPhoneNumber, completion: @escaping (Result<Void, ApiError>) -> Void)
    func registerUser(userInfo: RegisterNewUser, completion: @escaping (Result<Void, ApiError>) -> Void)
}

class VerifyOTPInteractor: VerifyOTPInteractorProtocol {

    var loginServiceManager: LoginServiceManagerProtocol?
    var registerServiceManager: RegistrationServiceManager?

    func verifyLoginOtp(otp: VerifyOTP, completion: @escaping (Result<LoginOTPResult, ApiError>) -> Void) {
        loginServiceManager?.verifyLoginOtp(otp: otp, completion: { result in
            switch result {
            case .success(let loginResult):
                completion(.success(loginResult))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func verifyRegistrationOtp(otp: VerifyOTP, completion: @escaping (Result<RegistrationOTPResult, ApiError>) -> Void) {
        registerServiceManager?.verifyRegistrationOtp(otp: otp, completion: { result in
            switch result {
            case .success(let registrationResult):
                completion(.success(registrationResult))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func loginUser(phoneNumber: LoginPhoneNumber, completion: @escaping (Result<Void, ApiError>) -> Void) {
        loginServiceManager?.loginUser(phoneNumber: phoneNumber, completion: { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }

    func registerUser(userInfo: RegisterNewUser, completion: @escaping (Result<Void, ApiError>) -> Void) {
        registerServiceManager?.registerUser(userInfo: userInfo, completion: { result in
            switch result {
            case .success():
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        })
    }
}
