//
//  AgeValidator.swift
//  EditPage
//
//  Created by Anton Ivchenko on 02.08.2024.
//

import Foundation

struct AgeValidator: PValidator {
    // MARK: - Interface
    func validate(_ value: Any) -> Bool {
        guard let value = value as? String else { return false }
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
