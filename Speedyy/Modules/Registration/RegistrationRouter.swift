//
//  RegistrationRouter.swift
//  Speedyy
//
//  Created by Shweta Talmale on 06/05/23.
//

import Foundation
import UIKit
 
protocol RegistrationRouterProtocol {
    func navigateToOTPVerification(userInfo: RegisterNewUser, hostVC: UIViewController)
    func navigateToBackScreen(hostVC: UIViewController)
    func getRegistrationViewController() -> UIViewController
    func showAlert(with msg: String, hostVC: UIViewController)
}

class RegistrationRouter: RegistrationRouterProtocol {
    func navigateToOTPVerification(userInfo: RegisterNewUser, hostVC: UIViewController) {
        DispatchQueue.main.async {
            let verifyVC = VerifyOTPRouter()
            let verifyOtpVC = verifyVC.getVerifyVCForRegistration(userInfo: userInfo)
            verifyOtpVC.modalPresentationStyle = .overFullScreen
            hostVC.present(verifyOtpVC, animated: true)
        }
    }

    func navigateToBackScreen(hostVC: UIViewController) {
        hostVC.dismiss(animated: false)
    }

    func getRegistrationViewController() -> UIViewController {
        let registrationVC = RegisterViewController()
        let registerPresenter = RegistrationPresenter()
        let registerInteractor = RegistrationInteractor()
        let registerService = RegistrationServiceManager()

        registrationVC.registerRouter = self
        registrationVC.registerPresenter = registerPresenter

        registerPresenter.registrationInteractor = registerInteractor
        registerPresenter.registrationView = registrationVC

        registerInteractor.registrationServiceManager = registerService
        return registrationVC
    }

    func showAlert(with msg: String, hostVC: UIViewController) {
        hostVC.showAlert(message: msg)
    }


}
