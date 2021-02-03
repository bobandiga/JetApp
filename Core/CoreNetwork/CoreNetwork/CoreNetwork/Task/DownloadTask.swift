//
//  DownloadTask.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 02.02.2021.
//

import Foundation

public final class DownloadTask: Task {
    
    private var resumeData: Data?
    
    public init(resumeData: Data?) {
        self.resumeData = resumeData
    }
    
    public init() {}
    
    public func prepareTask(session: URLSession, request: URLRequest) -> URLSessionTask {
        
        if let data = resumeData {
            return session.downloadTask(withResumeData: data)
        } else {
            return session.downloadTask(with: request)
        }
        
    }
    
}
