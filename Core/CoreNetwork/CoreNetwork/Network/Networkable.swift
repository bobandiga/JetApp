//
//  Networkable.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

public protocol Networkable {
    
    var urlComponents: URLComponents { get set }
    var headers: Headers { get set }
    
    func prepareForRequest(request: Requestable) -> URLRequest?
}
