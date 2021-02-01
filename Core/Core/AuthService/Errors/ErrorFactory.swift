//
//  ErrorFactory.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

public struct ErrorFactory {
    static func autoLogin() -> Error {
        return NSError(
            domain: "AuthService",
            code: 0,
            userInfo: [
                "title": "Auto login error",
                "message": "No user in key chain",
            ])
    }
}
