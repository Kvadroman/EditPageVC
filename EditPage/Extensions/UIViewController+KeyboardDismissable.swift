//
//  UIViewController+KeyboardDismissable.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

extension UIViewController {
    @discardableResult
    func hideKeyboardWhenTappedAround() -> UITapGestureRecognizer {
        let tapGestureRecognizer = UITapGestureRecognizer()
        tapGestureRecognizer.addTarget(self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGestureRecognizer)
        return tapGestureRecognizer
    }
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
