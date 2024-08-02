//
//  AgeValidator.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import Foundation

struct AgeValidator: PValidator {
    typealias Value = String
    // MARK: - Interface
    func validate(_ value: String, error: ((String) -> Void)?) -> Bool {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        guard let date = formatter.date(from: value) else { return false }
        return calculateAge(from: date) >= 18
    }
    // MARK: - Private methods
    private func calculateAge(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: Date()).year ?? 0
    }
}
