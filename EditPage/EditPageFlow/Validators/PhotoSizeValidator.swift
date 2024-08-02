//
//  PhotoSizeValidator.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

struct PhotoSizeValidator: PValidator {
    typealias Value = UIImage
    // MARK: - Properties
    private let errorMessage = "Photo size should not exceed 2 MB"
    // MARK: - Interface
    func validate(_ image: UIImage, error: ((String) -> Void)?) -> Bool {
        guard let imageData = image.jpegData(compressionQuality: 1.0) else { return false }
        let isValid = imageData.count <= 2 * 1024 * 1024
        if !isValid {
            error?(errorMessage)
        }
        return isValid
    }
}
