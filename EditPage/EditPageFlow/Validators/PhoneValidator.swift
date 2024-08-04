//
//  PhoneValidator.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

struct PhoneValidator: PValidator {
    // MARK: - Interface
    func validate(_ value: Any) -> Bool {
        guard let value = value as? String else { return false }
        let cleanedPhoneNumber = value.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let digitsAfterCountryCode = cleanedPhoneNumber.dropFirst(3)
        return digitsAfterCountryCode.count >= 11
    }
}
