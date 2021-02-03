//
//  BaseError.swift
//  CoreModels
//
//  Created by Максим Шаптала on 03.02.2021.
//

import Foundation

public protocol BaseError: Error {
    var title: String { get }
    var reason: String { get }
}
