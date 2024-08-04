//
//  DatePickerView.swift
//  EditPage
//
//  Created by Anton Ivchenko on 05.08.2024.
//

import UIKit

final class DatePickerView: UIView {
    // MARK: - Outlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var datePicker: UIDatePicker!
    @IBOutlet private var toolBar: UIToolbar!
    @IBOutlet private var bDone: UIBarButtonItem! {
        didSet {
            bDone.target = self
            bDone.action = #selector(doneButtonTapped)
        }
    }
    weak var textField: UITextField?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    // MARK: - Public methods
    func configure(textField: UITextField) {
        self.textField = textField
        textField.inputView = datePicker
        textField.inputAccessoryView = toolBar
        textField.delegate = self
    }
    // MARK: - Private methods
    private func commonInit() {
        Bundle.main.loadNibNamed(String.BundleName.datePickerView, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    @objc private func doneButtonTapped() {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        textField?.text = formatter.string(from: datePicker.date)
        textField?.resignFirstResponder()
    }
}

extension DatePickerView: UITextFieldDelegate {
    func textField(
        _ textField: UITextField,
        shouldChangeCharactersIn range: NSRange,
        replacementString string: String
    ) -> Bool {
        return false
    }
}
