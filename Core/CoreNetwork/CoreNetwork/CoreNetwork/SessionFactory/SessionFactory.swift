//
//  SessionFactory.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 02.02.2021.
//

import Foundation

public protocol SessionFactory {
    static func prepareSharedSession(sessionDelegate: URLSessionDelegate?, delegateQueue: OperationQueue?) -> URLSession
    static func preparePrivateSession(sessionDelegate: URLSessionDelegate?, delegateQueue: OperationQueue?) -> URLSession
}

extension SessionFactory {
    public static func prepareSharedSession(sessionDelegate: URLSessionDelegate?, delegateQueue: OperationQueue?) -> URLSession {
        let configuration = URLSessionConfiguration.default
        configuration.allowsCellularAccess = true
        configuration.allowsConstrainedNetworkAccess = true
        configuration.allowsExpensiveNetworkAccess = false
        configuration.requestCachePolicy = .returnCacheDataElseLoad
        
        return URLSession(configuration: configuration, delegate: sessionDelegate, delegateQueue: delegateQueue)
    }
    
    public static func preparePrivateSession(sessionDelegate: URLSessionDelegate?, delegateQueue: OperationQueue?) -> URLSession {
        let configuration = URLSessionConfiguration.ephemeral
        configuration.httpMaximumConnectionsPerHost = 1
        configuration.allowsCellularAccess = true
        configuration.allowsConstrainedNetworkAccess = true
        configuration.allowsExpensiveNetworkAccess = false
        configuration.httpCookieStorage = nil
        configuration.requestCachePolicy = .reloadIgnoringLocalAndRemoteCacheData
        
        return URLSession(configuration: configuration, delegate: sessionDelegate, delegateQueue: delegateQueue)
    }
}

public struct CoreSessionFactory: SessionFactory {}
