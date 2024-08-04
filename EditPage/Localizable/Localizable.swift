//
//  Localizable.swift
//  EditPage
//
//  Created by Anton Ivchenko on 05.08.2024.
//

import Foundation

extension String {
    struct BundleName {
        private init() {}
        static let editTextFieldView = "editTextField_View".localized
        static let editNavigationView = "editNavigation_View".localized
        static let editAvatarView = "editAvatar_View".localized
        static let datePickerView = "datePicker_View".localized
    }
    struct PhotoValidator {
        private init() {}
        static let error = "photoValidation_error".localized
    }
    struct Keychain {
        private init() {}
        static let userCredentials = "keychain_userCredentials".localized
    }
    struct FileManager {
        private init() {}
        static let avatar = "fileManager_avatar".localized
        static let savingError = "fileManagerSaving_error".localized
        static let loadingError = "fileManagerLoading_error".localized
    }
    struct AlertManager {
        private init() {}
        static let validationError = "validation_error".localized
        static let saveSuccessTitle = "saveSuccess_title".localized
        static let saveSuccessError = "saveSuccess_error".localized
        static let saveFailureTitle = "saveFailure_title".localized
        static let saveFailureError = "saveFailure_error".localized
    }
    struct DatePicker {
        private init() {}
        static let title = "datePicker_title".localized
    }
    struct TextFieldHeader {
        private init() {}
        static let fullName = "textFieldHeader_fullName".localized
        static let gender = "textFieldHeader_gender".localized
        static let birthday = "textFieldHeader_birthday".localized
        static let phoneNumber = "textFieldHeader_phoneNumber".localized
        static let email = "textFieldHeader_email".localized
        static let userName = "textFieldHeader_userName".localized
    }
}
