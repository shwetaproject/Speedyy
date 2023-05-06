//
//  ProfileViewController.swift
//  Speedyy
//
//  Created by Shweta Talmale on 05/05/23.
//

import UIKit
import PhotosUI

class ProfileViewController: UIViewController {

    let emailBottomLine = CALayer()
    let fullNameBottomLine = CALayer()
    let textFieldBottomLine = CALayer()
    let countryCodeBottomLine = CALayer()
    let altTextFieldBottomLine = CALayer()
    let altCountryCodeBottomLine = CALayer()

    private var profileServiceManagerDelegate: ProfileServiceManagerProtocol?

    var fullName: String?
    var email: String?
    var phone: String?
    var altPhone: String?
    var imageName: String?

    var loginResult: LoginOTPResult?
    var registrationOTPResult: RegistrationOTPResult?

    private let scrollView: UIScrollView = {
       let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.alwaysBounceVertical = true
        scrollView.keyboardDismissMode = .onDrag
        scrollView.isUserInteractionEnabled = true
        scrollView.backgroundColor = .systemYellow
        return scrollView
    }()

    private let avatarPlaceholderImageView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 60
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(systemName: "camera.fill")
        imageView.tintColor = .gray
        imageView.isUserInteractionEnabled = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let detailsView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.layer.cornerRadius = 20
        return view
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

    private let altPhoneNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Enter alternative Number"
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        return label
    }()

    private let altCountryCodeBtn: UIButton = {
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

    private let altPhoneNumberTextField: UITextField = {
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
        button.setTitle("Save Changes", for: .normal)
        button.tintColor = .white
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .bold)
        button.backgroundColor = .black
        button.layer.masksToBounds = true
        button.layer.cornerRadius = 25
        button.isEnabled = true
        return button
    }()

    init(loginResult: LoginOTPResult) {
        super.init(nibName: nil, bundle: nil)
        self.loginResult = loginResult
    }

    init(registrationOTPResult: RegistrationOTPResult) {
        super.init(nibName: nil, bundle: nil)
        self.registrationOTPResult = registrationOTPResult
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground

        configureViews()
        avatarPlaceholderImageView.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                                               action: #selector(didTapToUploadPhoto)))
        continueButton.addTarget(self, action: #selector(didTapContinueBtn), for: .touchUpInside)
        altPhoneNumberTextField.addTarget(self, action: #selector(didAltPhoneNumberUpdated), for: .editingChanged)
        fullNameTextField.addTarget(self, action: #selector(didFullNameUpdated), for: .editingChanged)
        emailTextField.addTarget(self, action: #selector(didEmailUpdated), for: .editingChanged)

        fullNameTextField.text = loginResult?.full_name
        emailTextField.text = loginResult?.email
        phoneNumberTextField.text = loginResult?.phone

        fullName = loginResult?.full_name
        email = loginResult?.email


    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        scrollView.frame = view.bounds
        scrollView.layoutIfNeeded()
        detailsView.layoutIfNeeded()

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

        altTextFieldBottomLine.frame = CGRect(x: 0, y: altPhoneNumberTextField.frame.height, width: altPhoneNumberTextField.frame.width, height: 1)
        altTextFieldBottomLine.backgroundColor = UIColor.lightGray.cgColor
        altPhoneNumberTextField.layer.addSublayer(altTextFieldBottomLine)

        altCountryCodeBottomLine.frame = CGRect(x: 0, y: altCountryCodeBtn.frame.height, width: altCountryCodeBtn.frame.width, height: 1)
        altCountryCodeBottomLine.backgroundColor = UIColor.lightGray.cgColor
        altCountryCodeBtn.layer.addSublayer(altCountryCodeBottomLine)

        didEmailUpdated()
        didFullNameUpdated()
        didPhoneNumberUpdated()
    }

    private func configureViews() {
        view.addSubview(scrollView)
        scrollView.addSubview(avatarPlaceholderImageView)
        scrollView.addSubview(detailsView)
        scrollView.addSubview(fullNameLabel)
        scrollView.addSubview(fullNameTextField)
        scrollView.addSubview(emailLabel)
        scrollView.addSubview(emailTextField)
        scrollView.addSubview(phoneNumberLabel)
        scrollView.addSubview(countryCodeBtn)
        scrollView.addSubview(phoneNumberTextField)
        scrollView.addSubview(altPhoneNumberLabel)
        scrollView.addSubview(altCountryCodeBtn)
        scrollView.addSubview(altPhoneNumberTextField)
        scrollView.addSubview(continueButton)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            avatarPlaceholderImageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor),
            avatarPlaceholderImageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 20),
            avatarPlaceholderImageView.widthAnchor.constraint(equalToConstant: 120),
            avatarPlaceholderImageView.heightAnchor.constraint(equalToConstant: 120),

            detailsView.topAnchor.constraint(equalTo: avatarPlaceholderImageView.bottomAnchor, constant: 40),
            detailsView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            detailsView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            detailsView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            detailsView.widthAnchor.constraint(equalToConstant: view.frame.width),
            detailsView.heightAnchor.constraint(equalToConstant: view.frame.height - 350),

            fullNameLabel.topAnchor.constraint(equalTo: detailsView.topAnchor, constant: 40),
            fullNameLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            fullNameLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            fullNameTextField.topAnchor.constraint(equalTo: fullNameLabel.bottomAnchor),
            fullNameTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            fullNameTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            fullNameTextField.heightAnchor.constraint(equalToConstant: 50),

            emailLabel.topAnchor.constraint(equalTo: fullNameTextField.bottomAnchor, constant: 40),
            emailLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            emailLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            emailTextField.topAnchor.constraint(equalTo: emailLabel.bottomAnchor),
            emailTextField.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            emailTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            emailTextField.heightAnchor.constraint(equalToConstant: 50),

            phoneNumberLabel.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 40),
            phoneNumberLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 120),
            phoneNumberLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            countryCodeBtn.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor),
            countryCodeBtn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            countryCodeBtn.heightAnchor.constraint(equalToConstant: 50),
            countryCodeBtn.widthAnchor.constraint(equalToConstant: 100),

            phoneNumberTextField.topAnchor.constraint(equalTo: phoneNumberLabel.bottomAnchor),
            phoneNumberTextField.leadingAnchor.constraint(equalTo: countryCodeBtn.trailingAnchor, constant: 16),
            phoneNumberTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            phoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),

            altPhoneNumberLabel.topAnchor.constraint(equalTo: phoneNumberTextField.bottomAnchor, constant: 40),
            altPhoneNumberLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 120),
            altPhoneNumberLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),

            altCountryCodeBtn.topAnchor.constraint(equalTo: altPhoneNumberLabel.bottomAnchor),
            altCountryCodeBtn.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 16),
            altCountryCodeBtn.heightAnchor.constraint(equalToConstant: 50),
            altCountryCodeBtn.widthAnchor.constraint(equalToConstant: 100),

            altPhoneNumberTextField.topAnchor.constraint(equalTo: altPhoneNumberLabel.bottomAnchor),
            altPhoneNumberTextField.leadingAnchor.constraint(equalTo: countryCodeBtn.trailingAnchor, constant: 16),
            altPhoneNumberTextField.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -16),
            altPhoneNumberTextField.heightAnchor.constraint(equalToConstant: 50),

            continueButton.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: scrollView.keyboardLayoutGuide.topAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
            continueButton.topAnchor.constraint(greaterThanOrEqualTo: altPhoneNumberTextField.bottomAnchor)
        ])
    }

    @objc private func didTapToUploadPhoto() {
        var configuration = PHPickerConfiguration()
        configuration.filter = .images
        configuration.selectionLimit = 1

        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
}

extension ProfileViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)

        for item in results {



            item.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.avatarPlaceholderImageView.image = image
                    }
                } else if let error = error {
                    let alertVC = UIAlertController(title: "Error",
                                                    message: error.localizedDescription,
                                                    preferredStyle: .alert)
                    let alertAction = UIAlertAction(title: "OK", style: .cancel)
                    alertVC.addAction(alertAction)
                    DispatchQueue.main.async {
                        self?.present(alertVC, animated: true)
                    }
                }
            }
            item.itemProvider.loadFileRepresentation(forTypeIdentifier: "public.item") { (url, error) in
                            if error != nil {
                               print("error \(error!)");
                            } else {
                                if let url = url {
                                    let filename = url.lastPathComponent;
                                    self.imageName = filename
                                }
                            }
                        }
        }
    }



    @objc private func didAltPhoneNumberUpdated() {
        if !(altPhoneNumberTextField.text?.isEmpty ?? false) {
            altTextFieldBottomLine.backgroundColor = UIColor.black.cgColor
            altPhoneNumberTextField.layer.addSublayer(altTextFieldBottomLine)

            altCountryCodeBottomLine.backgroundColor = UIColor.black.cgColor
            altCountryCodeBtn.layer.addSublayer(altCountryCodeBottomLine)

            altPhoneNumberLabel.textColor = .lightGray
        } else {
            textFieldBottomLine.backgroundColor = UIColor.lightGray.cgColor
            altPhoneNumberTextField.layer.addSublayer(textFieldBottomLine)

            altCountryCodeBottomLine.backgroundColor = UIColor.lightGray.cgColor
            altCountryCodeBtn.layer.addSublayer(altCountryCodeBottomLine)

            altPhoneNumberLabel.textColor = .black
        }

        guard let text = altPhoneNumberTextField.text, text.count == 10, NSCharacterSet(charactersIn: "0123456789").isSuperset(of: NSCharacterSet(charactersIn: text) as CharacterSet) else {
            continueButton.isEnabled = false
            return
        }
        continueButton.isEnabled = true
        altPhone = text
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
        guard let fullName, let email, let altPhone, let imageName, let loginResult else { return }
        let phoneNumber = "+91" + altPhone
        let userInfo = UpdateUserInfo(full_name: fullName, alternate_phone: phoneNumber, email: email, image_name: imageName)
        profileServiceManagerDelegate?.updateUserInfo(userInfo: userInfo, userId: loginResult.id ?? "") { result in
            switch result {
            case .success():
                print("success")
            case .failure(let error):
                print(error)
            }
        }
    }
}
