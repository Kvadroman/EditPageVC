//
//  KeychainManager.swift
//  EditPage
//
//  Created by Anton Ivchenko on 01.08.2024.
//

import Foundation
import UIKit

protocol PKeychainManager {
    func saveData(_ data: Data, forKey key: String) -> Bool
    func loadData(forKey key: String) -> Data?
    func deleteData(forKey key: String) -> Bool
}

final class KeychainManager: PKeychainManager {
    // MARK: - Interface
    func saveData(_ data: Data, forKey key: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecValueData: data
        ] as [CFString: Any]
        SecItemDelete(query as CFDictionary)
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    func loadData(forKey key: String) -> Data? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key,
            kSecReturnData: kCFBooleanTrue!,
            kSecMatchLimit: kSecMatchLimitOne
        ] as [CFString: Any]
        
        var dataTypeRef: AnyObject?
        let status = SecItemCopyMatching(query as CFDictionary, &dataTypeRef)
        
        if status == errSecSuccess {
            return dataTypeRef as? Data
        } else {
            return nil
        }
    }
    func deleteData(forKey key: String) -> Bool {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: key
        ] as [CFString: Any]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}


