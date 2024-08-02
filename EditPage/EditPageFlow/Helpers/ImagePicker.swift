//
//  ImagePicker.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

protocol PImagePicker {
    func pickImage(on viewController: UIViewController, completion: @escaping (UIImage?) -> Void)
}

final class ImagePicker: NSObject, PImagePicker {
    // MARK: - Properties
    private var pickImageCompletion: ((UIImage?) -> Void)?
    // MARK: - Interface
    func pickImage(on viewController: UIViewController, completion: @escaping (UIImage?) -> Void) {
        self.pickImageCompletion = completion
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        viewController.present(imagePickerController, animated: true, completion: nil)
    }
}

// MARK: - Delegates
extension ImagePicker: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
        pickImageCompletion?(nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        picker.dismiss(animated: true, completion: nil)
        let image = info[.originalImage] as? UIImage
        pickImageCompletion?(image)
    }
}
