//
//  GetTextRequest.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreNetwork

struct GetTextRequest: Requestable {
    var endpoint: String = "/get/text/"
    
    var method: RMethod = .get
    
    var timeout: TimeInterval = 15
    
    var cachePolicy: URLRequest.CachePolicy = .returnCacheDataElseLoad
    
    var headers: Headers = [:]
    
    var parameters: Parameters = [:]
    
    var jsonBody: JsonBody = [:]
    
    
}
