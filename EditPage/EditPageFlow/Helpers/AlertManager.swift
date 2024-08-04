//
//  AlertManager.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import UIKit

final class AlertManager {
    static func showAlert(from viewController: UIViewController, title: String, message: String) {
        let alert = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(
            UIAlertAction(
                title: "OK",
                style: .default,
                handler: nil
            )
        )
        viewController.present(alert, animated: true, completion: nil)
    }
}

struct AlertConfig {
    private typealias Strings = String.AlertManager
    // MARK: - Properties
    let title: String
    let errorMessage: String
    static let saveFailure: AlertConfig = .init(title: Strings.saveFailureTitle, errorMessage: Strings.saveFailureError)
    static let saveSuccess: AlertConfig = .init(title: Strings.saveSuccessTitle, errorMessage:  Strings.saveSuccessError)
}
