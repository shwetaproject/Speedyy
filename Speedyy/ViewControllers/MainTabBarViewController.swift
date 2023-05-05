//
//  MainTabBarViewController.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    var loginOtpResponse: LoginOTPResult?
    var registrationOTPResult: RegistrationOTPResult?
    init(loginOtpResponse: LoginOTPResult) {
        self.loginOtpResponse = loginOtpResponse
        super.init(nibName: nil, bundle: nil)
    }

    init(registrationOTPResult: RegistrationOTPResult) {
        self.registrationOTPResult = registrationOTPResult
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        let homeVC = UINavigationController(rootViewController: HomeViewController())
        homeVC.tabBarItem.image = UIImage(systemName: "house")

        var accountVC: UINavigationController?
        if let loginOtpResponse {
            accountVC = UINavigationController(rootViewController: ProfileViewController(loginResult: loginOtpResponse))
        } else if let registrationOTPResult {
            accountVC = UINavigationController(rootViewController: ProfileViewController(registrationOTPResult: registrationOTPResult))
        }

        accountVC?.tabBarItem.image = UIImage(systemName: "person.crop.circle")

        tabBar.tintColor = .black

        if let accountVC {
            let vcList = [homeVC, accountVC]
            setViewControllers(vcList, animated: true)
        }
    }
}
