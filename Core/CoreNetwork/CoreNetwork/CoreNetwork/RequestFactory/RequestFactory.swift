//
//  RequestFactory.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 02.02.2021.
//

import Foundation

public protocol RequestFactory {
    var urlComponents: URLComponents { get }
    var headers: Headers { get }
    init(urlComponents: URLComponents, headers: Headers)
    func prepareRequest(_ request: Requestable) -> URLRequest?
}
