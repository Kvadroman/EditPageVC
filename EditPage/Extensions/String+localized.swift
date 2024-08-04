//
//  String+localized.swift
//  EditPage
//
//  Created by Anton Ivchenko on 05.08.2024.
//

import Foundation

extension String {
    var localized: String {
        class Module {}
        return NSLocalizedString(self, bundle: Bundle(for: Module.self), comment: "")
    }
    func localizedFormat(_ args: CVarArg...) -> String {
        String(format: self.localized, arguments: args)
    }
}
