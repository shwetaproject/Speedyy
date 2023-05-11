//
//  LoginPresenter.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation

protocol LoginPresenterProtocol {
    func isValidPhoneNumber(for text: String) -> Bool
    func loginUser(phoneNumber: LoginPhoneNumber)
}

class LoginPresenter: LoginPresenterProtocol {

    weak var loginView: LoginViewProtocol?
    var loginInteractor: LoginInteractorProtocol?

    func isValidPhoneNumber(for text: String) -> Bool {
        text.isValidPhoneNumber()
    }
    
    func loginUser(phoneNumber: LoginPhoneNumber) {
        loginInteractor?.loginUser(phoneNumber: phoneNumber, completion: { [weak self] result in
            switch result {
            case .success():
                self?.loginView?.loginDidSuccess(phoneNumber: phoneNumber)
            case .failure(let error):
                self?.loginView?.showError(error: error)
            }
        })
    }
}
