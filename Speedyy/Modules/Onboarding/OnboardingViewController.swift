//
//  OnboardingViewController.swift
//  Speedyy
//
//  Created by Shweta Talmale on 04/05/23.
//

import UIKit

class OnboardingViewController: UIViewController {

    private var currentCellIndex = 0
    private var timer: Timer?
    var numberOfCells = 3
    private let viewTitleText = "SPEEDYY"

    let pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = 3
        pageControl.pageIndicatorTintColor = .gray
        pageControl.currentPageIndicatorTintColor = .black
        return pageControl
    }()

    private let appLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "Logo")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Speedyy"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private let scrollCollectionView: UICollectionView = {
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 450)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        collectionView.register(OnboardingCollectionViewCell.self,
                                forCellWithReuseIdentifier: OnboardingCollectionViewCell.identifier)
        return collectionView
    }()

    private let btnsStackView: UIStackView = {
        let view = UIStackView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.spacing = 8
        view.axis = .horizontal
        return view
    }()

    let loginsButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Login", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 15
        return button
    }()

    let registerButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Register", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemYellow
        button.layer.cornerRadius = 15
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "View controller"
        view.backgroundColor = .systemBackground

        scrollCollectionView.dataSource = self
        scrollCollectionView.delegate = self

        loginsButton.addTarget(self, action: #selector(didTapLoginBtn), for: .touchUpInside)
        registerButton.addTarget(self, action: #selector(didTapRegisterBtn), for: .touchUpInside)

        let headerMutableString = NSMutableAttributedString(string: viewTitleText,
                                                            attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: .light)])
        headerMutableString.addAttribute(NSAttributedString.Key.font,
                                            value: UIFont.systemFont(ofSize: 20, weight: .semibold),
                                            range: NSRange(location:2,length:2))
        headerMutableString.addAttribute(NSAttributedString.Key.font,
                                            value: UIFont.systemFont(ofSize: 20, weight: .heavy),
                                            range: NSRange(location:4,length:3))

        titleLabel.attributedText = headerMutableString

        timer = Timer.scheduledTimer(timeInterval: 2.0, target: self, selector: #selector(iCardSlideToNext), userInfo: nil, repeats: true)

        setUpViews()
    }

    @objc private func iCardSlideToNext() {
        if currentCellIndex < numberOfCells-1 {
            currentCellIndex = currentCellIndex + 1
        } else {
            currentCellIndex = 0
        }
        pageControl.currentPage = currentCellIndex
        scrollCollectionView.scrollToItem(at: IndexPath(item: currentCellIndex, section: 0), at: .right, animated: true)
    }

    private func setUpViews() {
        view.addSubview(appLogoImageView)
        view.addSubview(titleLabel)
        view.addSubview(scrollCollectionView)
        view.addSubview(pageControl)
        view.addSubview(btnsStackView)
        btnsStackView.addArrangedSubview(loginsButton)
        btnsStackView.addArrangedSubview(registerButton)

        NSLayoutConstraint.activate([
            appLogoImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 60),
            appLogoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            appLogoImageView.heightAnchor.constraint(equalToConstant: 50),
            appLogoImageView.widthAnchor.constraint(equalToConstant: 50),

            titleLabel.topAnchor.constraint(equalTo: appLogoImageView.bottomAnchor, constant: 8),
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            scrollCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 50),
            scrollCollectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollCollectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollCollectionView.heightAnchor.constraint(equalToConstant: 450),
            scrollCollectionView.widthAnchor.constraint(equalToConstant: view.frame.width),

            pageControl.topAnchor.constraint(equalTo: scrollCollectionView.bottomAnchor, constant: 20),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            btnsStackView.topAnchor.constraint(equalTo: pageControl.bottomAnchor, constant: 30),
            btnsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            loginsButton.heightAnchor.constraint(equalToConstant: 50),
            loginsButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 40),

            registerButton.heightAnchor.constraint(equalToConstant: 50),
            registerButton.widthAnchor.constraint(equalToConstant: view.frame.width/2 - 40)
        ])
    }
}

extension OnboardingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfCells
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OnboardingCollectionViewCell.identifier, for: indexPath) as? OnboardingCollectionViewCell {
            return cell
        }
        return UICollectionViewCell()
    }
}

extension OnboardingViewController {
    @objc private func didTapLoginBtn() {

        let loginRouter = LoginRouter()
        let loginVC = loginRouter.getLoginViewController()
        loginVC.modalPresentationStyle = .overFullScreen
        present(loginVC, animated: true)
    }

    @objc private func didTapRegisterBtn() {
        let registerVC = RegisterViewController()
        registerVC.modalPresentationStyle = .overFullScreen
        present(registerVC, animated: true)
    }
}
