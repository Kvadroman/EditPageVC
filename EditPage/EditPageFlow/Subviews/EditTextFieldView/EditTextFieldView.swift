//
//  EditTextFieldView.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

final class EditTextFieldView: UIView {
    // MARK: - Outlets
    @IBOutlet var contentView: UIView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var paddedTextField: PaddedTextField!
    // MARK: - Properties
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    var text: String? {
        get { paddedTextField.text }
        set { paddedTextField.text = newValue }
    }
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    func setBorderColor(_ color: UIColor) {
        paddedTextField.layer.borderColor = color.cgColor
        paddedTextField.layer.cornerRadius = 4
        paddedTextField.layer.borderWidth = 1.0
    }
    // MARK: - Private methods
    private func commonInit() {
        Bundle.main.loadNibNamed("EditTextFieldView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
}
