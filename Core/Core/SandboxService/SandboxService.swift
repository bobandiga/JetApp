//
//  SandboxService.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreNetwork
import CoreKeychain

public protocol SandboxServiceProtocol {
    func getText(for locale: String)
    func getPerson(for locale: String)
}

final public class SandboxService: SandboxServiceProtocol {
    
    private lazy var keychain = AuthKeychain()
    private lazy var network: Networkable = SandboxNetwork()
    private lazy var session: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = network.headers
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60 * 5
        configuration.httpMaximumConnectionsPerHost = 1
        return URLSession(configuration: configuration)
    }()
    
    public  init() {
        keychain.getObject { [weak self] (token) in
            guard let unwrapToken = token else { return }
            self?.network.headers["token"] = "Bearer \(unwrapToken)"
        }
    }
    
    // MARK: - API
    public func getText(for locale: String) {
        var req = GetTextRequest()
        req.parameters["locale"] = locale
        
        guard let urlRequest = SandboxNetwork().prepareForRequest(request: req) else { return }
        let task = session.dataTask(with: urlRequest) { (d, r, e) in
            if let error = e {
                return
            }
            
            guard let response = r as? HTTPURLResponse, let data = d else { return }
            
        }
        task.resume()
    }
    
    public func getPerson(for locale: String) {
        var req = GetPersonRequest()
        req.parameters["locale"] = locale
        
        guard let urlRequest = SandboxNetwork().prepareForRequest(request: req) else { return }
        let task = session.dataTask(with: urlRequest) { (d, r, e) in
            if let error = e {
                return
            }
            
            guard let response = r as? HTTPURLResponse, let data = d else { return }
            
        }
        task.resume()
    }
    
}
