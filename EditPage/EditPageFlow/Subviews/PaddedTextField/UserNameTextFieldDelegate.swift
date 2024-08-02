//
//  UserNameTextFieldDelegate.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

final class UserNameTextFieldDelegate: NSObject, UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        // Get the current text value
        let currentText = textField.text ?? ""
        // Create a new text value considering the changes
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        // Check and add "@" at the beginning if it's not there
        if !updatedText.hasPrefix("@") {
            textField.text = "@\(updatedText)"
            return false
        }
        return true
    }
}
