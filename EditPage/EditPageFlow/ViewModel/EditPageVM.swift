//
//  EditPageVM.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

final class EditPageVM: PEditPageVM {
    // MARK: - Interface
    var input: Input = .init()
    var output: Output = .init()
    // MARK: - Properties
    private var userCredentialsTextFieldValues: [String] {
        [
            userCredentials.fullName,
            userCredentials.gender,
            userCredentials.birthdate,
            userCredentials.phoneNumber,
            userCredentials.email,
            userCredentials.username,
        ]
    }
    private var photoSizeValidator: AnyValidator<UIImage> = AnyValidator(PhotoSizeValidator())
    private let ageValidator: AnyValidator<String> = AnyValidator(AgeValidator())
    private let phoneValidator: AnyValidator<String> = AnyValidator(PhoneValidator())
    private var userCredentials: UserCredentials = .init()
    private var imagePicker: PImagePicker = ImagePicker()
    private let keychainManager: PKeychainManager = KeychainManager()
    private let imageFileManager: PEditFileManager = EditFileManager()
    private let textFieldHeaders: [String] = [
        "Full name",
        "Gender",
        "Birthday",
        "Phone number",
        "Email",
        "User name",
    ]
    // MARK: - Init
    init() {
        bind()
    }
    // MARK: - Private methods
    private func bind() {
        input.viewDidLoad = { [weak self] in
            guard let self else { return }
            loadCredentials()
            output.onSetupTextFields?(textFieldHeaders, userCredentialsTextFieldValues)
        }
        input.saveButtonTapped = { [weak self] in
            guard let self, validate($0) else { return }
            saveCredentials()
        }
        input.openImagePicker = { [weak self] viewController in
            self?.openImagePicker(on: viewController)
        }
    }
    private func validate(_ models: [String]) -> Bool {
        var validationResults = [Bool]()
        for (index, model) in models.enumerated() {
            var isValid = true
            switch index {
            case 0:
                userCredentials.fullName = model
                isValid = !model.isEmpty
            case 1:
                userCredentials.gender = model
                isValid = !model.isEmpty
            case 2:
                userCredentials.birthdate = model
                isValid = ageValidator.validate(model)
            case 3:
                userCredentials.phoneNumber = model
                isValid = phoneValidator.validate(model)
            case 4:
                userCredentials.email = model
                isValid = !model.isEmpty
            case 5:
                userCredentials.username = model
                isValid = !(model.count <= 1)
            default: break
            }
            validationResults.append(isValid)
        }
        output.onValidationResult?(validationResults)
        return validationResults.allSatisfy ({ $0 })
    }
    private func openImagePicker(on viewController: UIViewController) {
        imagePicker.pickImage(on: viewController) { [weak self] image in
            guard let self,
                  let image,
                  self.photoSizeValidator.validate(image, error: { errorMessage in
                      self.output.showAlert?(AlertConfig(title: "Validation Error", errorMessage: errorMessage))
                  })
            else { return }
            let photoURL = imageFileManager.saveImage(image, withName: "avatar")
            userCredentials.photoURL = photoURL
            output.onImageSelected?(image)
        }
    }
    private func saveCredentials() {
        guard let data = try? JSONEncoder().encode(userCredentials),
        keychainManager.saveData(data, forKey: "userCredentials")
        else {
            output.showAlert?(AlertConfig.saveFailure)
            return
        }
        output.showAlert?(AlertConfig.saveSuccess)
        output.onSetupTextFields?(textFieldHeaders, userCredentialsTextFieldValues)
    }
    private func loadCredentials() {
        guard let data = keychainManager.loadData(forKey: "userCredentials"),
              let decoded = try? JSONDecoder().decode(UserCredentials.self, from: data)
        else { return }
        userCredentials = decoded
        guard let photoURL = userCredentials.photoURL else { return }
        let photo = imageFileManager.loadImage(with: photoURL)
        output.onImageSelected?(photo)
    }
}
