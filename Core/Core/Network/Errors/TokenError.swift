//
//  TokenError.swift
//  Core
//
//  Created by Максим Шаптала on 03.02.2021.
//

import Foundation
import CoreModels

public struct TokenError: BaseError  {
    
    public var title: String = "Token error"
    public var reason: String = "No token for request"
    
    public init() {}
}
