//
//  RequestError.swift
//  Core
//
//  Created by Максим Шаптала on 03.02.2021.
//

import Foundation
import CoreModels

public struct RequestError: BaseError {
    
    public var title: String = "Response error"
    public var reason: String = "No http response"
    
    public init() {}
    
}
