//
//  EditPageVC.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

final class EditPageVC: UIViewController {
    // MARK: - Outlets
    @IBOutlet private var vEditNavigation: EditNavigationView!
    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private var vEditAvatar: EditAvatarView!
    @IBOutlet private var lFullName: UILabel!
    @IBOutlet private var lUserName: UILabel!
    @IBOutlet private var vFullNameTextField: EditTextFieldView!
    @IBOutlet private var vGenderTextField: EditTextFieldView!
    @IBOutlet private var vBirthdayTextField: EditTextFieldView! {
        didSet {
            datePickerManager.configure(textField: vBirthdayTextField.paddedTextField)
        }
    }
    @IBOutlet private var vPhoneTextField: EditTextFieldView! {
        didSet { 
            vPhoneTextField.paddedTextField.delegate = phoneTextFieldDelegate
            vPhoneTextField.paddedTextField.keyboardType = .phonePad
        }
    }
    @IBOutlet private var vEmailTextField: EditTextFieldView!
    @IBOutlet private var vUserNameTextField: EditTextFieldView! {
        didSet { vUserNameTextField.paddedTextField.delegate = userNameTextFieldDelegate }
    }
    @IBOutlet private var saveButton: UIButton! {
        didSet {
            saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        }
    }
    // MARK: - Properties
    private var textFields: [EditTextFieldView] {
        [
            vFullNameTextField,
            vGenderTextField,
            vBirthdayTextField,
            vPhoneTextField,
            vEmailTextField,
            vUserNameTextField
        ]
    }
    private var viewModel: PEditPageVM = EditPageVM()
    private var datePicker: UIDatePicker?
    private var keyboardHandler: KeyboardHandler?
    private let phoneTextFieldDelegate = PhoneTextFieldDelegate()
    private let userNameTextFieldDelegate = UserNameTextFieldDelegate()
    private let datePickerManager = DatePickerManager()
    // MARK: - Overriden methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        bindInputs()
        bindOutputs()
        hideKeyboardWhenTappedAround()
        viewModel.input.viewDidLoad?()
        keyboardHandler = KeyboardHandler(scrollView: scrollView, textFields: textFields.map { $0.paddedTextField })
    }
    // MARK: - Private methods
    private func setupView() {
        overrideUserInterfaceStyle = .light
        navigationController?.isNavigationBarHidden = true
    }
    private func bindInputs() {
        vEditNavigation.backAction = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        vEditAvatar.attachAction = { [weak self] in
            guard let self else { return }
            viewModel.input.openImagePicker?(self)
        }
    }
    private func bindOutputs() {
        viewModel.output.onSetupTextFields = { [weak self] headers, model in
            guard let self else { return }
            for (index, textField) in textFields.enumerated() {
                textField.title = headers[index]
                textField.text = model[index]
                lFullName.text = model.first ?? ""
                lUserName.text = model.last ?? ""
            }
        }
        viewModel.output.onImageSelected = { [weak self] image in
            guard let image else { return }
            self?.vEditAvatar.attachImage(image)
        }
        viewModel.output.onValidationResult = { [weak self] validationResults in
            guard let self else { return }
            for (index, textField) in self.textFields.enumerated() {
                if validationResults[index] {
                    textField.setBorderColor(.clear)
                } else {
                    textField.setBorderColor(.red)
                }
            }
        }
        viewModel.output.showAlert = { [weak self] config in
            guard let self else { return }
            AlertManager.showAlert(
                from: self,
                title: config.title,
                message: config.errorMessage
            )
        }
    }
    @objc private func saveButtonTapped() {
        var credentials = [String]()
        textFields.forEach {
            credentials.append($0.text ?? "")
        }
        viewModel.input.saveButtonTapped?(credentials)
    }
}
