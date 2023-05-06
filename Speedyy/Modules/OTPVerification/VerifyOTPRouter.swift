//
//  VerifyOTPRouter.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation
import UIKit
 
protocol VerifyOTPRouterProtocol {
    func navigateRegistrationToHome(result: RegistrationOTPResult, hostVC: UIViewController)
    func navigateLoginToHome(result: LoginOTPResult, hostVC: UIViewController)
    func navigateToBackScreen(hostVC: UIViewController)
    func getVerifyVCForRegistration(userInfo: RegisterNewUser) -> UIViewController
    func getVerifyVCForLogin(phoneNumber: String) -> UIViewController
    func showAlert(with msg: String, hostVC: UIViewController)
}

class VerifyOTPRouter: VerifyOTPRouterProtocol {
    func navigateRegistrationToHome(result: RegistrationOTPResult, hostVC: UIViewController) {
        DispatchQueue.main.async {
            let homeVC = MainTabBarViewController(registrationOTPResult: result)
            homeVC.modalPresentationStyle = .overFullScreen
            hostVC.present(homeVC, animated: true)
        }
    }

    func navigateLoginToHome(result: LoginOTPResult, hostVC: UIViewController) {
        DispatchQueue.main.async {
            let homeVC = MainTabBarViewController(loginOtpResponse: result)
            homeVC.modalPresentationStyle = .overFullScreen
            hostVC.present(homeVC, animated: true)
        }
    }

    func navigateToBackScreen(hostVC: UIViewController) {
        hostVC.dismiss(animated: false)
    }

    func getVerifyVCForRegistration(userInfo: RegisterNewUser) -> UIViewController {
        let verificationVC = VerifyOTPViewController(userInfo: userInfo)
        let verifyPresenter = VerifyOTPPresenter()
        let verifyInteractor = VerifyOTPInteractor()
        let loginService = LoginServiceManager()
        let registrationService = RegistrationServiceManager()

        verificationVC.verifyRouter = self
        verificationVC.verifyOTPPresenter = verifyPresenter

        verifyPresenter.verifyInteractor = verifyInteractor
        verifyPresenter.verifyView = verificationVC

        verifyInteractor.loginServiceManager = loginService
        verifyInteractor.registerServiceManager = registrationService
        return verificationVC
    }

    func getVerifyVCForLogin(phoneNumber: String) -> UIViewController {
        let verificationVC = VerifyOTPViewController(phoneNumber: phoneNumber)
        let verifyPresenter = VerifyOTPPresenter()
        let verifyInteractor = VerifyOTPInteractor()
        let loginService = LoginServiceManager()
        let registrationService = RegistrationServiceManager()

        verificationVC.verifyRouter = self
        verificationVC.verifyOTPPresenter = verifyPresenter

        verifyPresenter.verifyInteractor = verifyInteractor
        verifyPresenter.verifyView = verificationVC

        verifyInteractor.loginServiceManager = loginService
        verifyInteractor.registerServiceManager = registrationService
        return verificationVC
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
