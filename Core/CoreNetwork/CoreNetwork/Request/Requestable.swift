//
//  Requestable.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

public typealias Parameters = [String: String?]
public typealias Headers = [String: String]
public typealias JsonBody = [String: Any?]

public protocol Requestable {
    
    var endpoint: String { get }
    var method: Method { get }
    var requestType: RequestType { get }
    var timeout: TimeInterval { get }
    
    var cachePolicy: URLRequest.CachePolicy { get }
    
    var headers: Headers { get }
    var parameters: Parameters { get set }
    var jsonBody: JsonBody { get set }
}
