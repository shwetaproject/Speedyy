//
//  RegistrationPresenter.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation

protocol RegistrationPresenterProtocol {
    func isValidPhoneNumber(for text: String) -> Bool
    func registerUser(userInfo: RegisterNewUser)
}

class RegistrationPresenter: RegistrationPresenterProtocol {

    weak var registrationView: RegistrationViewProtocol?
    var registrationInteractor: RegistrationInteractorProtocol?

    func isValidPhoneNumber(for text: String) -> Bool {
        guard text.count == 10,
              NSCharacterSet(charactersIn: "0123456789").isSuperset(of: NSCharacterSet(charactersIn: text) as CharacterSet) else {
            return false
        }
        return true
    }

    func registerUser(userInfo: RegisterNewUser) {
        registrationInteractor?.registerUser(userInfo: userInfo, completion: { result in
            switch result {
            case .success():
                self.registrationView?.registrationDidSuccess(userInfo: userInfo)
            case .failure(let error):
                self.registrationView?.showError(error: error)
            }
        })
    }


}
