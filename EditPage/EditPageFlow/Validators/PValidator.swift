//
//  PValidator.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import Foundation

protocol PValidator {
    associatedtype Value
    func validate(_ value: Value, error: ((String) -> Void)?) -> Bool
}

struct AnyValidator<Value>: PValidator {
    // MARK: - Properties
    private let _validate: (Value, ((String) -> Void)?) -> Bool
    // MARK: - Init
    init<V: PValidator>(_ validator: V) where V.Value == Value {
        _validate = validator.validate
    }
    // MARK: - Interface
    func validate(_ value: Value, error: ((String) -> Void)? = nil) -> Bool {
        _validate(value, error)
    }
}
