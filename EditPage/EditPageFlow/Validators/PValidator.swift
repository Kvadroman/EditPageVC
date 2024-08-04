//
//  PValidator.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import Foundation

protocol PValidator {
    var error: ((String) -> Void)? { get set }
    func validate(_ value: Any) -> Bool
}

extension PValidator {
    var error: ((String) -> Void)? {
        get { { _ in } }
        set {}
    }
}
