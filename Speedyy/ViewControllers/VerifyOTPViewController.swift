//
//  VerifyOTPViewController.swift
//  Speedyy
//
//  Created by Shweta Talmale on 04/05/23.
//

import UIKit

class VerifyOTPViewController: UIViewController {

    private var otpString = ""
    private var phoneNumber: String?
    private var subTitleLabelText = "Enter the code we just sent to\n"
    private let apiCaller = ApiCaller()

    private var userInfo: RegisterNewUser?

    var time = 0
    var timer: Timer?

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
        label.text = "Verify Phone"
        label.font = .systemFont(ofSize: 20, weight: .semibold)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 14, weight: .regular)
        return label
    }()

    let textField1: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.setupOTPTextField()
        textfield.becomeFirstResponder()
        return textfield
    }()

    let textField2: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.setupOTPTextField()
        return textfield
    }()

    let textField3: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.setupOTPTextField()
        return textfield
    }()

    let textField4: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.setupOTPTextField()
        return textfield
    }()

    let textField5: UITextField = {
       let textfield = UITextField()
        textfield.translatesAutoresizingMaskIntoConstraints = false
        textfield.setupOTPTextField()
        return textfield
    }()

    private let otpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.distribution = .fillProportionally
        return stackView
    }()


    private let timerLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10, weight: .regular)
        label.textColor = .gray
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

    private let resendOTPSMSBtn: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        let text = "Resend OTP"
        let yourAttributes: [NSAttributedString.Key: Any] = [
              .font: UIFont.systemFont(ofSize: 10),
              .foregroundColor: UIColor.gray,
              .underlineStyle: NSUnderlineStyle.single.rawValue
          ]
        let attributedString = NSMutableAttributedString(
                string: text,
                attributes: yourAttributes
             )
        button.setAttributedTitle(attributedString, for: .normal)
        button.isHidden = true
        button.contentHorizontalAlignment = .left
        return button
    }()

    init(userInfo: RegisterNewUser) {
        super.init(nibName: nil, bundle: nil)
        self.userInfo = userInfo
    }

    init(phoneNumber: String) {
        super.init(nibName: nil, bundle: nil)
        self.phoneNumber = phoneNumber
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"
        view.backgroundColor = .systemBackground

        hideKeyboardWhenTappedAround()
        configureViews()
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        resendOTPSMSBtn.addTarget(self, action: #selector(didTapResendOtp), for: .touchUpInside)
        continueButton.addTarget(self, action: #selector(didTapContinueBtn), for: .touchUpInside)

        subTitleLabelText += userInfo?.phone ?? ""
        subTitleLabel.text = subTitleLabelText

        setupOTPTextField()
        startEvent()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

    }

        private func setupOTPTextField() {
            let textFieldArray = [textField1, textField2, textField3, textField4, textField5]
            textFieldArray.forEach { textField in
                otpStackView.addArrangedSubview(textField)
                textField.addTarget(nil, action: #selector(textFieldDidChange), for: .editingChanged)
            }
        }

    @objc private func textFieldDidChange(textField: UITextField) {
        let text = textField.text

        if text?.count == 1 {
            textField.backgroundColor = UIColor(named: "RedLight")
            switch textField {
            case textField1:
                otpString.append(textField1.text ?? "")
                textField2.becomeFirstResponder()
            case textField2:
                otpString.append(textField2.text ?? "")
                textField3.becomeFirstResponder()
            case textField3:
                otpString.append(textField3.text ?? "")
                textField4.becomeFirstResponder()
            case textField4:
                otpString.append(textField4.text ?? "")
                textField5.becomeFirstResponder()
            case textField5:
                otpString.append(textField5.text ?? "")
                textField5.resignFirstResponder()
                continueButton.isEnabled = true
            default: break
            }
        }

        if text?.count == 0 {
            textField.backgroundColor = .white
            switch textField {
            case textField1:
                textField1.becomeFirstResponder()
            case textField2:
                textField1.becomeFirstResponder()
            case textField3:
                textField2.becomeFirstResponder()
            case textField4:
                textField3.becomeFirstResponder()
            case textField5:
                textField4.becomeFirstResponder()
                continueButton.isEnabled = false
            default: break
            }
        }
    }

    private func configureViews() {
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(subTitleLabel)
        view.addSubview(otpStackView)
        view.addSubview(continueButton)
        view.addSubview(timerLabel)
        view.addSubview(resendOTPSMSBtn)

        NSLayoutConstraint.activate([
            backButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            backButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),

            titleLabel.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: 40),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            subTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            otpStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            otpStackView.topAnchor.constraint(equalTo: subTitleLabel.bottomAnchor, constant: 30),

            timerLabel.topAnchor.constraint(equalTo: otpStackView.bottomAnchor, constant: 16),
            timerLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            timerLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            resendOTPSMSBtn.topAnchor.constraint(equalTo: otpStackView.bottomAnchor, constant: 16),
            resendOTPSMSBtn.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            resendOTPSMSBtn.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),

            continueButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            continueButton.bottomAnchor.constraint(equalTo: view.keyboardLayoutGuide.topAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 50),
        ])
    }

    @objc private func didTapBackButton() {
        dismiss(animated: false)
    }

    @objc private func didChangeTextField(textField: UITextField) {
        guard let text = textField.text, text.count == 10, NSCharacterSet(charactersIn: "0123456789").isSuperset(of: NSCharacterSet(charactersIn: text) as CharacterSet) else {
            continueButton.isEnabled = false
            return
        }
        continueButton.isEnabled = true
    }

    func startEvent() {
        time = 0
        timerLabel.isHidden = false
        resendOTPSMSBtn.isHidden = true
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateLabel), userInfo: nil, repeats: true)
    }

    @objc func updateLabel() {
        time += 1
        let updatedTime = 10 - time
        if String(updatedTime).count == 1 {
            timerLabel.text = "Resend Code in 00:0\(updatedTime)"
        } else {
            timerLabel.text = "Resend Code in 00:\(updatedTime)"
        }

        if time == 10 {
            timerReset()
        }
    }

    private func timerReset() {
        timer?.invalidate()
        timer = nil
        timerLabel.isHidden = true
        resendOTPSMSBtn.isHidden = false
    }

    @objc private func didTapResendOtp() {
        if let userInfo {
            startEvent()
            apiCaller.registerUser(userInfo: userInfo) { result in
                switch result {
                case .success():
                    print("resent otp")
                case .failure(let error):
                    print(error)
                }
            }
        } else if let phoneNumber {
            startEvent()
            let loginPhNo = LoginPhoneNumber(phone: phoneNumber)
            apiCaller.loginUser(phoneNumber: loginPhNo) { result in
                switch result {
                case .success():
                    print("resent otp")
                case .failure(let error):
                    print(error)
                }
            }
        }
    }

    @objc private func didTapContinueBtn() {
        guard let userInfo else {
            verifyLoginOtp()
            return }
        let otp = VerifyOTP(phone: userInfo.phone, otp: otpString)
        apiCaller.verifyRegistrationOtp(otp: otp) { [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    let homeVC = MainTabBarViewController(registrationOTPResult: result)
                    homeVC.modalPresentationStyle = .overFullScreen
                    self?.present(homeVC, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }

    private func verifyLoginOtp() {
        guard let phoneNumber else { return }
        let otp = VerifyOTP(phone: phoneNumber, otp: otpString)
        apiCaller.verifyLoginOtp(otp: otp) { [weak self] result in
            switch result {
            case .success(let result):
                DispatchQueue.main.async {
                    let homeVC = MainTabBarViewController(loginOtpResponse: result)
                    homeVC.modalPresentationStyle = .overFullScreen
                    self?.present(homeVC, animated: true)
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
