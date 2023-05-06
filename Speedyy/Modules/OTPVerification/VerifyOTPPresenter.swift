//
//  VerifyOTPPresenter.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation

protocol VerifyOTPPresenterProtocol {
    func verifyLoginOtp(otp: VerifyOTP)
    func verifyRegistrationOtp(otp: VerifyOTP)
    func loginUser(phoneNumber: LoginPhoneNumber)
    func registerUser(userInfo: RegisterNewUser)
}

class VerifyOTPPresenter: VerifyOTPPresenterProtocol {

    weak var verifyView: VerifyOTPViewProtocol?
    var verifyInteractor: VerifyOTPInteractorProtocol?

    func verifyLoginOtp(otp: VerifyOTP) {
        verifyInteractor?.verifyLoginOtp(otp: otp, completion: { [weak self] result in
            switch result {
            case .success(let loginResult):
                self?.verifyView?.loginVerificationDidSuccess(loginResult: loginResult)
            case .failure(let error):
                self?.verifyView?.showError(error: error)
            }
        })
    }
    
    func verifyRegistrationOtp(otp: VerifyOTP) {
        verifyInteractor?.verifyRegistrationOtp(otp: otp, completion: { [weak self] result in
            switch result {
            case .success(let registrationResult):
                self?.verifyView?.registrationVerificationDidSuccess(registrationResult: registrationResult)
            case .failure(let error):
                self?.verifyView?.showError(error: error)
            }
        })
    }

    func loginUser(phoneNumber: LoginPhoneNumber) {
        verifyInteractor?.loginUser(phoneNumber: phoneNumber, completion: { [weak self] result in
            switch result {
            case .success():
                self?.verifyView?.resendLoginOTPDidSuccess()
            case .failure(let error):
                self?.verifyView?.showError(error: error)
            }
        })
    }

    func registerUser(userInfo: RegisterNewUser) {
        verifyInteractor?.registerUser(userInfo: userInfo, completion: { [weak self] result in
            switch result {
            case .success():
                self?.verifyView?.resendRegistrationOTPDidSuccess()
            case .failure(let error):
                self?.verifyView?.showError(error: error)
            }
        })
    }
}
