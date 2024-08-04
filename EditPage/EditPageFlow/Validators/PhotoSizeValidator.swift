//
//  PhotoSizeValidator.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

struct PhotoSizeValidator: PValidator {
    var error: ((String) -> Void)?
    // MARK: - Properties
    private let errorMessage = String.PhotoValidator.error
    // MARK: - Interface
    func validate(_ value: Any) -> Bool {
        guard let value = value as? UIImage,
              let imageData = value.jpegData(compressionQuality: 1.0) else { return false }
        let isValid = imageData.count <= 2 * 1024 * 1024
        if !isValid {
            error?(errorMessage)
        }
        return isValid
    }
}
