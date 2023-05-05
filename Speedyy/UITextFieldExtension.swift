//
//  UITextFieldExtension.swift
//  Speedyy
//
//  Created by Shweta Talmale on 04/05/23.
//

import UIKit

extension UITextField {
    func setupOTPTextField() {
        self.keyboardType = .numberPad
        self.returnKeyType = .done
        self.autocorrectionType = .no
        self.textContentType = .oneTimeCode
        self.autocapitalizationType = .none


        
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .center
        self.attributedPlaceholder = NSAttributedString(
            string: "0",
            attributes: [.paragraphStyle: centeredParagraphStyle])
        self.heightAnchor.constraint(equalToConstant: 45).isActive = true
        self.widthAnchor.constraint(equalToConstant: 45).isActive = true
        self.textAlignment = .center
        self.textColor = .gray

        self.textAlignment = .center

        let textFieldBottomLine = CALayer()
        textFieldBottomLine.frame = CGRect(x: 0, y: 35, width: 35, height: 1)
        textFieldBottomLine.backgroundColor = UIColor.gray.cgColor
        self.layer.addSublayer(textFieldBottomLine)
    }
}
