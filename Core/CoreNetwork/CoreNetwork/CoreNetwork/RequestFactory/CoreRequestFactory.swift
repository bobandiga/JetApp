//
//  CoreRequestFactory.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 02.02.2021.
//

import Foundation

public final class CoreRequestFactory: RequestFactory {

    public var urlComponents: URLComponents
    public var headers: Headers
    
    public init(urlComponents: URLComponents, headers: Headers) {
        self.urlComponents = urlComponents
        self.headers = headers
    }
    
    public func prepareRequest(_ request: Requestable) -> URLRequest? {
        
        var copyUrlComponents = urlComponents
        copyUrlComponents.path.append(request.endpoint)
        copyUrlComponents.queryItems = request.parameters.compactMap { URLQueryItem(name: $0.key, value: $0.value) }
        guard let url = copyUrlComponents.url else { return nil }
        
        var urlRequest = URLRequest(url: url, cachePolicy: request.cachePolicy, timeoutInterval: request.timeout)
        urlRequest.allHTTPHeaderFields = headers
        urlRequest.httpMethod = request.method.rawValue
        request.headers.forEach { urlRequest.setValue($0.value, forHTTPHeaderField: $0.key) }
        
        guard !request.jsonBody.isEmpty else {
            return urlRequest
        }
        urlRequest.httpBody = try? JSONSerialization.data(withJSONObject: request.jsonBody)
        
        return urlRequest
    }
    
    //public func prepareUploadReques() -> URLRequest?
    //public func prepareOtherReques() -> URLRequest?
    //...
}

