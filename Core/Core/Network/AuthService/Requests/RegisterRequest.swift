//
//  RegisterRequest.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreNetwork

public struct RegisterRequest: Requestable {
    public var jsonBody: JsonBody = [:]
    
    
    public var endpoint: String = "/signup/"
    
    public var method: RMethod = .post
    
    
    public var timeout: TimeInterval = 15
    
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    public var headers: Headers = [:]
    
    public var parameters: Parameters = [:]
    
    public var httpBodyData: Data?
    
}
