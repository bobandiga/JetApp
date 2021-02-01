//
//  LoginRequest.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreNetwork

public struct LoginRequest: Requestable {
    public var jsonBody: JsonBody = [:]
    
    
    public var endpoint: String = "/login"
    
    public var method: CoreNetwork.Method = .post
    
    public var requestType: RequestType = .simple
    
    public var timeout: TimeInterval = 15
    
    public var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    public var headers: Headers = [:]
    
    public var parameters: Parameters = [:]
    
    
}
