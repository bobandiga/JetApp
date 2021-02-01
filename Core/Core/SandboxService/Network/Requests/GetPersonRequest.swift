//
//  GetPersonRequest.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreNetwork

struct GetPersonRequest: Requestable {
    var endpoint: String = "/get/person"
    
    var method: CoreNetwork.Method = .get
    
    var requestType: RequestType = .simple
    
    var timeout: TimeInterval = 15
    
    var cachePolicy: URLRequest.CachePolicy = .reloadIgnoringLocalAndRemoteCacheData
    
    var headers: Headers = [:]
    
    var parameters: Parameters = [:]
    
    var jsonBody: JsonBody = [:]
    
    
}
