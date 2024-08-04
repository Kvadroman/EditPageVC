//
//  EditAvatarView.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

final class EditAvatarView: UIView {
    // MARK: - Outlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var imageView: UIImageView!
    @IBOutlet private var tappableView: UIView! {
        didSet {
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapImage))
            tappableView.addGestureRecognizer(tapGesture)
        }
    }
    // MARK: - Bind property
    var attachAction: (() -> Void)?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    // MARK: - Interface
    func attachImage(_ image: UIImage) {
        imageView.image = image
    }
    // MARK: - Private methods
    private func commonInit() {
        Bundle.main.loadNibNamed(String.BundleName.editAvatarView, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    @objc private func tapImage() {
        attachAction?()
    }
}
