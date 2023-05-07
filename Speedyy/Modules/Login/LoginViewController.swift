//
//  LoginViewController.swift
//  Speedyy
//
//  Created by Shweta Talmale on 04/05/23.
//

import UIKit

protocol LoginViewProtocol: AnyObject {
    func loginDidSuccess(phoneNumber: LoginPhoneNumber)
    func showError(error: ApiError)
}

class LoginViewController: UIViewController {

    var loginPresenter: LoginPresenterProtocol?
    var loginRouter: LoginRouterProtocol?
    private var phone = ""


    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGray
        button.layer.cornerRadius = 15
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Welcome Back"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Fill the details to continue"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    private let countryCodeBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .black
        button.setTitle("🇮🇳 +91", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .left
        button.titleLabel?.lineBreakMode = .byTruncatingTail
        button.setImage(UIImage(systemName: "chevron.down"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        return button
    }()

    private let phoneNumberTextField: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .numberPad
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Phone Number",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.gray])


        return textfield
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "By continuing you may receive a SMS for verification.\n Message and data rates may apply"
        label.textColor = .gray
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Continue", for: .normal)
        button.tintColor = .black
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .systemYellow
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.isEnabled = false
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .systemBackground

        hideKeyboardWhenTappedAround()
        configureViews()
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        phoneNumberTextField.addTarget(self, action: #selector(didChangeTextField), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(didTapContinueBtn), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        let textFieldBottomLine = CALayer()
        textFieldBottomLine.frame = CGRect(x: 0, y: phoneNumberTextField.frame.height, width: phoneNumberTextField.frame.width, height: 1)
        textFieldBottomLine.backgroundColor = UIColor.gray.cgColor
        phoneNumberTextField.layer.addSublayer(textFieldBottomLine)

        let countryCodeBottomLine = CALayer()
        countryCodeBottomLine.frame = CGRect(x: 0, y: countryCodeBtn.frame.height, width: countryCodeBtn.frame.width, height: 1)
        countryCodeBottomLine.backgroundColor = UIColor.gray.cgColor
        countryCodeBtn.layer.addSublayer(countryCodeBottomLine)
    }

    private func configureViews() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(countryCodeBtn)
        view.addSubview(phoneNumberTextField)
        view.addSubview(continueButton)
        view.addSubview(infoLabel)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            countryCodeBtn.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 40),
            countryCodeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            countryCodeBtn.heightAnchor.constraint(equalToConstant: 50),
            countryCodeBtn.widthAnchor.constraint(equalToConstant: 100),

            phoneNumberTextField.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 40),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: countryCodeBtn.trailingAnchor, constant: 16),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),

            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50),

            infoLabel.bottomAnchor.constraint(equalTo: continueButton.topAnchor, constant: -16),
            infoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            infoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }

    @objc private func didTapBackButton() {
        loginRouter?.navigateToBackScreen(hostVC: self)
    }

    @objc private func didChangeTextField(textField: UITextField) {
        guard let text = textField.text, loginPresenter?.isValidPhoneNumber(for: text) ?? false else {
            continueButton.isEnabled = false
            return
        }
        continueButton.isEnabled = true
        phone = text
    }

    @objc private func didTapContinueBtn() {

        let phoneNumber = "+91" + phone
        let loginPhoneNumber = LoginPhoneNumber(phone: phoneNumber)
        loginPresenter?.loginUser(phoneNumber: loginPhoneNumber)
    }
}

extension LoginViewController: LoginViewProtocol {
    func loginDidSuccess(phoneNumber: LoginPhoneNumber) {
        loginRouter?.navigateToOTPVerification(phoneNumber: phoneNumber.phone, hostVC: self)
    }

    func showError(error: ApiError) {
        loginRouter?.showAlert(with: error.message ?? "Process failed", hostVC: self)
    }
}
