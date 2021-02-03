//
//  DataError.swift
//  Core
//
//  Created by Максим Шаптала on 03.02.2021.
//

import Foundation
import CoreModels

public struct DataError: BaseError {
    
    public var title: String = "Data error"
    public var reason: String = "No data from response"
    
    public init() {}
}
