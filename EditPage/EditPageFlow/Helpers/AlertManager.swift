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
    // MARK: - Properties
    let title: String
    let errorMessage: String
    static let saveFailure: AlertConfig = .init(title: "Failure", errorMessage: "Credentials aren't saved!")
    static let saveSuccess: AlertConfig = .init(title: "Success", errorMessage: "Successfully Saved!")
}
