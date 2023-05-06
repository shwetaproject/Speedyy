//
//  ProfileRouter.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation
import UIKit

protocol ProfileRouterProtocol {
    func getProfileVCForRegistration(registrationOTPResult: RegistrationOTPResult) -> UIViewController
    func getProfileVCForLogin(loginOTPResult: LoginOTPResult) -> UIViewController
    func showAlert(with msg: String, hostVC: UIViewController)
}

class ProfileRouter: ProfileRouterProtocol {
    func getProfileVCForRegistration(registrationOTPResult: RegistrationOTPResult) -> UIViewController {
        let profileVC = ProfileViewController(registrationOTPResult: registrationOTPResult)
        let profilePresenter = ProfilePresenter()
        let profileInteractor = ProfileInteractor()
        let profileService = ProfileServiceManager()

        profileVC.profileRouter = self
        profileVC.profilePresenter = profilePresenter

        profilePresenter.profileInteractor = profileInteractor
        profilePresenter.profileView = profileVC

        profileInteractor.profileServiceManager = profileService
        return profileVC
    }

    func getProfileVCForLogin(loginOTPResult: LoginOTPResult) -> UIViewController {
        let profileVC = ProfileViewController(loginResult: loginOTPResult)
        let profilePresenter = ProfilePresenter()
        let profileInteractor = ProfileInteractor()
        let profileService = ProfileServiceManager()

        profileVC.profileRouter = self
        profileVC.profilePresenter = profilePresenter

        profilePresenter.profileInteractor = profileInteractor
        profilePresenter.profileView = profileVC

        profileInteractor.profileServiceManager = profileService
        return profileVC
    }


    func showAlert(with msg: String, hostVC: UIViewController) {
        let alertVC = UIAlertController(title: "Error", message: msg, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(alertAction)

        DispatchQueue.main.async {
            hostVC.present(alertVC, animated: true)
        }
    }
}
