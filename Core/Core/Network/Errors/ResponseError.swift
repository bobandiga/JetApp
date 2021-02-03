//
//  NetworkError.swift
//  Core
//
//  Created by Максим Шаптала on 03.02.2021.
//

import Foundation
import CoreModels

public struct ResponseError: BaseError {
    
    public var title: String = "Response error"
    public var reason: String
    
    public init(code: Int) {
        switch code {
        case (100...199):
            reason = "Information error with \(code)"
            return
        case (300...399):
            reason = "Routing error with \(code)"
            return
        case (400...499):
            reason = "Client error with \(code)"
            return
        case (500...599):
            reason = "Server error with \(code)"
            return
        default:
            title  = ""
            reason = ""
        }
    }
}
