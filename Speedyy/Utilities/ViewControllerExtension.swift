//
//  ViewControllerExtension.swift
//  Speedyy
//
//  Created by Shweta Talmale on 04/05/23.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard() {
        view.endEditing(true)
    }

    func showAlert(message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .cancel)
        alertVC.addAction(alertAction)

        DispatchQueue.main.async { [weak self] in
            self?.present(alertVC, animated: true)
        }
    }
}
