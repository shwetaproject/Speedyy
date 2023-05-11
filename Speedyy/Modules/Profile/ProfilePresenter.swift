//
//  ProfilePresenter.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation
 
protocol ProfilePresenterProtocol {
    func updateUserInfo(userInfo: UpdateUserInfo, userId: String)
    func isValidPhoneNumber(for text: String) -> Bool
}

class ProfilePresenter: ProfilePresenterProtocol {
    weak var profileView: ProfileViewProtocol?
    var profileInteractor: ProfileInteractorProtocol?

    func updateUserInfo(userInfo: UpdateUserInfo, userId: String) {
        profileInteractor?.updateUserInfo(userInfo: userInfo, userId: userId, completion: { [weak self] result in
            switch result {
            case .success():
                self?.profileView?.profileUpdateDidSuccess(userInfo: userInfo, userId: userId)
            case .failure(let error):
                self?.profileView?.showError(error: error)
            }
        })
    }

    func isValidPhoneNumber(for text: String) -> Bool {
        guard text.count == 10,
              NSCharacterSet(charactersIn: "0123456789").isSuperset(of: NSCharacterSet(charactersIn: text) as CharacterSet) else {
            return false
        }
        return true
    }
}
