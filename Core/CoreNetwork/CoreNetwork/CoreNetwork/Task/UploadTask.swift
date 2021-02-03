//
//  UploadTask.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 02.02.2021.
//

import Foundation

public final class UploadTask: Task {
    
    private var completion: TaskCompletion?
    private var data: Data
    
    public init(data: Data, _ completion: @escaping TaskCompletion) {
        self.data = data
        self.completion = completion
    }
    
    public init(data: Data) {
        self.data = data
    }
    
    public func prepareTask(session: URLSession, request: URLRequest) -> URLSessionTask {
        if let completion = completion {
            return session.uploadTask(with: request, from: data, completionHandler: completion)
        } else {
            return session.uploadTask(with: request, from: data)
        }
    }
}
