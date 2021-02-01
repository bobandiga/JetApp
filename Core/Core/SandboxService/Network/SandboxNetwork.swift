//
//  SandboxNetwork.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreNetwork

final class SandboxNetwork: Networkable {
    public var headers: Headers = ["Content-Type":"application/json"]
    
    public lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "apiecho.cf"
        components.path = "/api"
        return components
    }()
    
    public func prepareForRequest(request: Requestable) -> URLRequest? {
        urlComponents.path.append(request.endpoint)
        urlComponents.queryItems = request.parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        urlComponents.path.append("/")
        guard let url = urlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url, cachePolicy: request.cachePolicy, timeoutInterval: request.timeout)
        urlRequest.httpMethod = request.method.rawValue
       
        request.headers.forEach { urlRequest.addValue($0.value, forHTTPHeaderField: $0.key) }
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: request.jsonBody, options: .fragmentsAllowed)
        
        return urlRequest
    }
}

