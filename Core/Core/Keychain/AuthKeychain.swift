//
//  AuthKeychain.swift
//  CoreKeychain
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import Security
import CoreKeychain

struct AuthKeychain: KeyChainable {
    
    public init() {}
    
    public func setObject(object: String) {
        guard let data: Data = object.data(using: .utf8) else { return }
        let keychainItemQuery = [
            kSecValueData: data,
            kSecAttrComment: "token",
            kSecClass: kSecClassGenericPassword
        ] as CFDictionary
        
        guard let _  = getObject() else {
            let _ = SecItemAdd(keychainItemQuery, nil)
            return
        }
        let updateFields = [
          kSecValueData: "newPassword".data(using: .utf8)!
        ] as CFDictionary
        let _ = SecItemUpdate(keychainItemQuery, updateFields)
    }
    
    public func getObject() -> String? {
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrComment: "token",
            kSecReturnAttributes: true,
            kSecReturnData: true,
            kSecMatchLimit: 5
        ] as CFDictionary
        
        var result: AnyObject?
        let _ = SecItemCopyMatching(query, &result)
        
        guard let dic = result as? [NSDictionary], let tokenData = dic.first?[kSecValueData] as? Data else {
            return nil
        }
        
        guard let token = String(data: tokenData, encoding: .utf8) else { return nil }
        return token
    }
    
    public func deleteObject() {
        let query = [
          kSecClass: kSecClassGenericPassword,
        kSecAttrComment: "token",
        ] as CFDictionary

        let _ = SecItemDelete(query)
    }
    
}
