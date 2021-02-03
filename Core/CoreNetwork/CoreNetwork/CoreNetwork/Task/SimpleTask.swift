//
//  SimpleTask.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 02.02.2021.
//

import Foundation

public final class SimpleTask: Task {
    
    private var completion: TaskCompletion?
    
    public init(_ completion: @escaping TaskCompletion) {
        self.completion = completion
    }
    
    public init() {}
    
    public func prepareTask(session: URLSession, request: URLRequest) -> URLSessionTask {
        if let completion = completion {
            return session.dataTask(with: request, completionHandler: completion)
        } else {
            return session.dataTask(with: request)
        }
    }
    
}
