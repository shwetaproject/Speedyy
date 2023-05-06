//
//  RegisterViewController.swift
//  Speedyy
//
//  Created by Shweta Talmale on 04/05/23.
//

import UIKit

class RegisterViewController: UIViewController {

    let emailBottomLine = CALayer()
    let fullNameBottomLine = CALayer()
    let textFieldBottomLine = CALayer()
    let countryCodeBottomLine = CALayer()

    var fullName: String?
    var email: String?
    var phone: String?

    private var registrationServiceManagerDelegate: RegistrationServiceManagerProtocol?

    let backButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 15
        button.heightAnchor.constraint(equalToConstant: 30).isActive = true
        button.widthAnchor.constraint(equalToConstant: 30).isActive = true
        return button
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Create Account"
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

    private let fullNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Full name"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let fullNameTextField: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .default
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Enter your name",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return textfield
    }()

    private let emailLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Email"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let emailTextField: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.keyboardType = .default
        textfield.autocorrectionType = .no
        textfield.autocapitalizationType = .none
        textfield.attributedPlaceholder = NSAttributedString(
            string: "Enter your Email",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return textfield
    }()

    private let phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter Phone Number"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
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
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.lightGray])
        return textfield
    }()

    private let infoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.text = "By clicking create account, you are agree to our\n Terms of Service and Privacy Policy statement."
        label.textColor = .lightGray
        label.font = .systemFont(ofSize: 14)
        return label
    }()

    private let continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Proceed", for: .normal)
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
        title = "Register"
        view.backgroundColor = .systemBackground

        hideKeyboardWhenTappedAround()
        configureViews()
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        phoneNumberTextField.addTarget(self, action: #selector(didPhoneNumberUpdated), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(didFullNameUpdated), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(didEmailUpdated), for: .editingChanged)
        continueButton.addTarget(self, action: #selector(didTapContinueBtn), for: .touchUpInside)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        emailBottomLine.frame = CGRect(x: 0, y: emailTextField.frame.height, width: emailTextField.frame.width, height: 1)
        emailBottomLine.backgroundColor = UIColor.lightGray.cgColor
        emailTextField.layer.addSublayer(emailBottomLine)

        fullNameBottomLine.frame = CGRect(x: 0, y: fullNameTextField.frame.height, width: fullNameTextField.frame.width, height: 1)
        fullNameBottomLine.backgroundColor = UIColor.lightGray.cgColor
        fullNameTextField.layer.addSublayer(fullNameBottomLine)

        textFieldBottomLine.frame = CGRect(x: 0, y: phoneNumberTextField.frame.height, width: phoneNumberTextField.frame.width, height: 1)
        textFieldBottomLine.backgroundColor = UIColor.lightGray.cgColor
        phoneNumberTextField.layer.addSublayer(textFieldBottomLine)

        countryCodeBottomLine.frame = CGRect(x: 0, y: countryCodeBtn.frame.height, width: countryCodeBtn.frame.width, height: 1)
        countryCodeBottomLine.backgroundColor = UIColor.lightGray.cgColor
        countryCodeBtn.layer.addSublayer(countryCodeBottomLine)
    }

    private func configureViews() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)

        view.addSubview(fullNameLabel)
        view.addSubview(fullNameTextField)
        view.addSubview(emailLabel)
        view.addSubview(emailTextField)

        view.addSubview(phoneNumberLabel)
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

            fullNameLabel.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 40),
            fullNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            fullNameTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor),
            fullNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            fullNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 50),

            emailLabel.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            phoneNumberLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 120),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            countryCodeBtn.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor),
            countryCodeBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            countryCodeBtn.heightAnchor.constraint(equalToConstant: 50),
            countryCodeBtn.widthAnchor.constraint(equalToConstant: 100),

            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor),
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
        dismiss(animated: false)
    }

    @objc private func didPhoneNumberUpdated() {
        if !(phoneNumberTextField.text?.isEmpty ?? false) {
            textFieldBottomLine.backgroundColor = UIColor.black.cgColor
            phoneNumberTextField.layer.addSublayer(textFieldBottomLine)

            countryCodeBottomLine.backgroundColor = UIColor.black.cgColor
            countryCodeBtn.layer.addSublayer(countryCodeBottomLine)

            phoneNumberLabel.textColor = .lightGray
        } else {
            textFieldBottomLine.backgroundColor = UIColor.lightGray.cgColor
            phoneNumberTextField.layer.addSublayer(textFieldBottomLine)

            countryCodeBottomLine.backgroundColor = UIColor.lightGray.cgColor
            countryCodeBtn.layer.addSublayer(countryCodeBottomLine)

            phoneNumberLabel.textColor = .black
        }

        guard let text = phoneNumberTextField.text, text.count == 10, NSCharacterSet(charactersIn: "0123456789").isSuperset(of: NSCharacterSet(charactersIn: text) as CharacterSet) else {
            continueButton.isEnabled = false
            return
        }
        continueButton.isEnabled = true
        phone = text
    }

    @objc private func didFullNameUpdated() {
        if !(fullNameTextField.text?.isEmpty ?? false) {
            fullNameBottomLine.backgroundColor = UIColor.black.cgColor
            fullNameTextField.layer.addSublayer(fullNameBottomLine)

            fullNameLabel.textColor = .lightGray
            fullName = fullNameTextField.text
        } else {
            fullNameBottomLine.backgroundColor = UIColor.lightGray.cgColor
            fullNameTextField.layer.addSublayer(fullNameBottomLine)

            fullNameLabel.textColor = .black
        }
    }

    @objc private func didEmailUpdated() {
        if !(emailTextField.text?.isEmpty ?? false) {
            emailBottomLine.backgroundColor = UIColor.black.cgColor
            emailTextField.layer.addSublayer(emailBottomLine)

            emailLabel.textColor = .lightGray

            email = emailTextField.text
        } else {
            emailBottomLine.backgroundColor = UIColor.lightGray.cgColor
            emailTextField.layer.addSublayer(emailBottomLine)

            emailLabel.textColor = .black
        }
    }

    @objc private func didTapContinueBtn() {
        guard let fullName, let email, let phone else { return }
        let phoneNumber = "+91" + phone
        let userInfo = RegisterNewUser(full_name: fullName, phone: phoneNumber, email: email)
        registrationServiceManagerDelegate?.registerUser(userInfo: userInfo) { [weak self] result in
            switch result {
            case .success():
                DispatchQueue.main.async {
                    let verifyOtpVC = VerifyOTPViewController(userInfo: userInfo)
                    verifyOtpVC.modalPresentationStyle = .overFullScreen
                    self?.present(verifyOtpVC, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }


    }
}
