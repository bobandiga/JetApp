//
//  Task.swift
//  CoreNetwork
//
//  Created by Максим Шаптала on 02.02.2021.
//

import Foundation

public typealias TaskCompletion = (Data?, URLResponse?, Error?) -> Void

public protocol Task {
    func prepareTask(session: URLSession, request: URLRequest) -> URLSessionTask
}
