//
//  Requestable.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 02.02.2021.
//

import Foundation

public typealias Headers       = [String: String]
public typealias Parameters    = [String: String]
public typealias JsonBody      = [String: Any?]

public protocol Requestable {
    var method          : RMethod { get }
    var endpoint        : String { get }
    
    var timeout         : TimeInterval { get }
    var cachePolicy     : URLRequest.CachePolicy { get }
    
    var headers         : Headers { get set }
    var parameters      : Parameters { get set }
    var jsonBody        : JsonBody { get set }
}

