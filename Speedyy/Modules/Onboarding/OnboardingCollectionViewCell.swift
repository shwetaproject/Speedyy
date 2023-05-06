//
//  OnboardingCollectionViewCell.swift
//  Speedyy
//
//  Created by Shweta Talmale on 04/05/23.
//

import UIKit

class OnboardingCollectionViewCell: UICollectionViewCell {
    static let identifier = "OnboardingCollectionViewCell"

    private let deliveryBoyImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "DeliveryBoy")
        return imageView
    }()

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Simple, Fast and Convenient"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        return label
    }()

    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Get everything delivered in 10 mins"
        label.font = .systemFont(ofSize: 18, weight: .regular)
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        addSubview(deliveryBoyImageView)
        addSubview(titleLabel)
        addSubview(subTitleLabel)
        configureConstraints()
    }

    private func configureConstraints() {
        NSLayoutConstraint.activate([
            deliveryBoyImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            deliveryBoyImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            deliveryBoyImageView.heightAnchor.constraint(equalToConstant: 300),
            deliveryBoyImageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width - 100),

            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: deliveryBoyImageView.bottomAnchor, constant: 50),

            subTitleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
