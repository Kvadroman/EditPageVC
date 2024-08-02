//
//  PhoneTextFieldDelegate.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

final class PhoneTextFieldDelegate: NSObject, UITextFieldDelegate {
    // MARK: - Delegate
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let currentText = textField.text ?? ""
        guard let stringRange = Range(range, in: currentText) else { return false }
        let updatedText = currentText.replacingCharacters(in: stringRange, with: string)
        let formattedText = format(phoneNumber: updatedText)
        textField.text = formattedText
        return false
    }
    // MARK: - Private methods
    private func format(phoneNumber: String) -> String {
        let cleanedPhoneNumber = phoneNumber.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let mask = "(+XXX) XXXXXXXXXXXX"
        var result = ""
        var index = cleanedPhoneNumber.startIndex
        for ch in mask where index < cleanedPhoneNumber.endIndex {
            if ch == "X" {
                result.append(cleanedPhoneNumber[index])
                index = cleanedPhoneNumber.index(after: index)
            } else {
                result.append(ch)
            }
        }
        return result
    }
}
