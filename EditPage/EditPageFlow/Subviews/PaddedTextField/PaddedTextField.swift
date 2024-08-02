//
//  PaddedTextField.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

final class PaddedTextField: UITextField {
    
    var textPadding = UIEdgeInsets(
        top: 15,
        left: 10,
        bottom: 3,
        right: 0
    )
    // Override textRect to change the bounds of the text
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
    // Override editingRect to change the bounds of the text while editing
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
    // Override placeholderRect to change the bounds of the placeholder
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        bounds.inset(by: textPadding)
    }
}
