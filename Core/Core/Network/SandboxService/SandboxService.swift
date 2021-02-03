//
//  SandboxService.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreNetwork
import CoreKeychain

public protocol SandboxServiceDelegate: class {
    func didFinish(error: Error)
    func didFinish(data: String)
}
 
public protocol SandboxServiceProtocol: class {
    var delegate: SandboxServiceDelegate? { get set }
    func getText(for locale: String)
    func getPerson(for locale: String)
}

final public class SandboxService: SandboxServiceProtocol {
    
    public weak var delegate: SandboxServiceDelegate?
    private let keychainService = AuthKeychain()
    private lazy var requestFactory : RequestFactory = {
        var components = URLComponents.create(scheme: .https, host: "apiecho.cf")
        components.path = "/api"
        let headers = ["Content-Type":"application/json"]
        let reqF =  CoreRequestFactory(urlComponents: components, headers: headers)
        return reqF
    }()
    
    public init() {}
    
    // MARK: - API
    public func getText(for locale: String) {
        
        guard let token = keychainService.getObject() else {
            delegate?.didFinish(error: TokenError())
            return
        }
        
        var req = GetTextRequest()
        req.headers["Authorization"] = "Bearer \(token)"
        req.parameters["locale"] = locale
        guard let urlRequest = requestFactory.prepareRequest(req) else { return }
        let session = CoreSessionFactory.prepareSharedSession(sessionDelegate: nil, delegateQueue: nil)
        let task = SimpleTask({ [weak self] (d, r, e) in
            self?.handleResponse(data: d, response: r, error: e)
        }).prepareTask(session: session, request: urlRequest)
        task.resume()
    }
    
    public func getPerson(for locale: String) {
        
        guard let token = keychainService.getObject() else {
            delegate?.didFinish(error: TokenError())
            return
        }
        
        var req = GetPersonRequest()
        req.headers["Authorization"] = "Bearer \(token)"
        req.parameters["locale"] = locale
        guard let urlRequest = requestFactory.prepareRequest(req) else { return }
        let session = CoreSessionFactory.prepareSharedSession(sessionDelegate: nil, delegateQueue: nil)
        let task = SimpleTask({ [weak self] (d, r, e) in
            self?.handleResponse(data: d, response: r, error: e)
        }).prepareTask(session: session, request: urlRequest)
        task.resume()
    }
    
}

extension SandboxService {
    func handleResponse(data: Data?, response: URLResponse?, error: Error?) {
        if let error = error {
            delegate?.didFinish(error: error)
            return
        }
        guard let response = response as? HTTPURLResponse else {
            delegate?.didFinish(error: RequestError())
            return
        }
        guard (200...299) ~= response.statusCode else {
            delegate?.didFinish(error: ResponseError(code: response.statusCode))
            return
        }
        guard let data = data, let string = String(data: data, encoding: .utf8) else {
            delegate?.didFinish(error: DataError())
            return
        }
        delegate?.didFinish(data: string)
    }
}
