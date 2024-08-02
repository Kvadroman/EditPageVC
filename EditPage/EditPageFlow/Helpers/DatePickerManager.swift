//
//  DatePickerManager.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

final class DatePickerManager: NSObject {
    // MARK: - Properties
    private weak var textField: UITextField?
    private var toolbar: UIToolbar!
    private let datePicker = UIDatePicker()
    // MARK: - Configure
    func configure(textField: UITextField) {
        self.textField = textField
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        textField.inputView = datePicker
        toolbar = UIToolbar()
        toolbar.sizeToFit()
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .plain,
            target: self,
            action: #selector(doneButtonTapped)
        )
        toolbar.setItems([doneButton], animated: false)
        textField.inputAccessoryView = toolbar
        textField.delegate = self
    }
    // MARK: - Private methods
    @objc private func doneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        textField?.text = formatter.string(from: datePicker.date)
        textField?.resignFirstResponder()
    }
}

extension DatePickerManager: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return false
    }
}

