//
//  KeyboardHandler.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

final class KeyboardHandler {
    // MARK: - Properties
    private weak var scrollView: UIScrollView?
    private var textFields: [UITextField]
    // MARK: - Init
    init(scrollView: UIScrollView, textFields: [UITextField]) {
        self.scrollView = scrollView
        self.textFields = textFields
        setupNotifications()
    }
    deinit {
        removeNotifications()
    }
    // MARK: - Private methods
    private func setupNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    private func removeNotifications() {
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    @objc private func keyboardWillShow(notification: NSNotification) {
        guard let scrollView,
              let userInfo = notification.userInfo,
              let keyboardFrame = (userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
        else { return }
        let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardFrame.height, right: 0)
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
        guard let activeTextField = textFields.first(where: { $0.isFirstResponder }) else { return }
        let textFieldFrame = activeTextField.convert(activeTextField.bounds, to: scrollView)
        scrollView.scrollRectToVisible(textFieldFrame, animated: true)
    }
    @objc private func keyboardWillHide(notification: NSNotification) {
        guard let scrollView else { return }
        let contentInset = UIEdgeInsets.zero
        scrollView.contentInset = contentInset
        scrollView.scrollIndicatorInsets = contentInset
    }
}

