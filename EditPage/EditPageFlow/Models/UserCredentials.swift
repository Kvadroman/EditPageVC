//
//  UserCredentials.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import Foundation

struct UserCredentials: Codable {
    // MARK: - Properties
    var fullName: String
    var gender: String
    var birthdate: String
    var phoneNumber: String
    var email: String
    var username: String
    var photoURL: URL?
    // MARK: - Init
    init(
        fullName: String = "",
        gender: String = "",
        birthdate: String = "",
        phoneNumber: String = "",
        email: String = "",
        username: String = "",
        photoURL: URL? = nil
    ) {
        self.fullName = fullName
        self.gender = gender
        self.birthdate = birthdate
        self.phoneNumber = phoneNumber
        self.email = email
        self.username = username
        self.photoURL = photoURL
    }
}
