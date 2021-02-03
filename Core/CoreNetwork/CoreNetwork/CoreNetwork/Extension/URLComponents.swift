//
//  URLComponents.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 03.02.2021.
//

import Foundation

public enum Scheme: String {
    case http  = "http"
    case https = "https"
}

public extension URLComponents {
    static func create(scheme: Scheme, host: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = scheme.rawValue
        components.host = host
        return components
    }
}
