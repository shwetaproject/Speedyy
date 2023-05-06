//
//  LoginRouter.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation
import UIKit

protocol LoginRouterProtocol {
    func navigateToOTPVerification(phoneNumber: String, hostVC: UIViewController)
    func navigateToBackScreen(hostVC: UIViewController)
    func getLoginViewController() -> UIViewController
    func showAlert(with msg: String, hostVC: UIViewController)
}

class LoginRouter: LoginRouterProtocol {

    func navigateToOTPVerification(phoneNumber: String, hostVC: UIViewController) {
        DispatchQueue.main.async {
            let verifyVC = VerifyOTPRouter()
            let verifyOtpVC = verifyVC.getVerifyVCForLogin(phoneNumber: phoneNumber)
            verifyOtpVC.modalPresentationStyle = .overFullScreen
            hostVC.present(verifyOtpVC, animated: true)
        }
    }

    func navigateToBackScreen(hostVC: UIViewController) {
        hostVC.dismiss(animated: false)
    }

    func getLoginViewController() -> UIViewController {
        let loginVC = LoginViewController()
        let loginPresenter = LoginPresenter()
        let loginInteractor = LoginInteractor()
        let loginService = LoginServiceManager()

        loginVC.loginRouter = self
        loginVC.loginPresenter = loginPresenter

        loginPresenter.loginInteractor = loginInteractor
        loginPresenter.loginView = loginVC

        loginInteractor.loginServiceManager = loginService
        return loginVC
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
