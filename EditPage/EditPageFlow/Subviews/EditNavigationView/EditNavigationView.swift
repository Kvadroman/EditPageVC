//
//  EditNavigationView.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import UIKit

final class EditNavigationView: UIView {
    // MARK: - Outlets
    @IBOutlet private var contentView: UIView!
    @IBOutlet private var backButton: UIButton! {
        didSet { backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)}
    }
    @IBOutlet private var lTitle: UILabel! {
        didSet {
            lTitle.adjustsFontSizeToFitWidth = true
            lTitle.maximumContentSizeCategory = .accessibilityLarge
        }
    }
    // MARK: - Bind property
    var backAction: (() -> Void)?
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        Bundle.main.loadNibNamed(String.BundleName.editNavigationView, owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    @objc private func backButtonTapped() {
        backAction?()
    }
}
