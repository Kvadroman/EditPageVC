//
//  PEditPageVM.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

protocol PEditPageVM {
    var input: Input { get }
    var output: Output { get set }
}

struct Input {
    var viewDidLoad: (() -> Void)?
    var saveButtonTapped: (([String]) -> Void)?
    var openImagePicker: ((UIViewController) -> Void)?
}

struct Output {
    var onSetupTextFields: (([String], [String]) -> Void)?
    var onImageSelected: ((UIImage?) -> Void)?
    var onValidationResult: (([Bool]) -> Void)?
    var showAlert: ((_ config: AlertConfig) -> Void)?
}
