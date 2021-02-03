//
//  AuthResponse.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

public struct AuthResponse: Decodable {
    let success: Bool
    let data: UserResponse
}


public struct UserResponse: Decodable {
    let email: String
    let name: String
    let access_token: String
}
