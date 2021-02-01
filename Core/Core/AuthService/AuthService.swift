//
//  AuthService.swift
//  Core
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreNetwork
import CoreKeychain

public protocol AuthServiceDelegate: class {
    func didFinish(error: Error?)
}

public protocol AutoAuthService: class {
    func autoLogin()
    var delegate: AuthServiceDelegate? { get set }
}

public protocol ManualAuthService: class {
    var delegate: AuthServiceDelegate? { get set }
    func login(email: String, password: String)
    func register(name: String, email: String, password: String)
    func logout()
}

final public class AuthService: NSObject, ManualAuthService, AutoAuthService {
    
    public weak var delegate: AuthServiceDelegate?
    private lazy var keychain = AuthKeychain()
    private lazy var network: Networkable = AuthNetwork()
    private lazy var session: URLSession = {
        var configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = network.headers
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 60
        configuration.timeoutIntervalForResource = 60 * 5
        configuration.httpMaximumConnectionsPerHost = 1
        return URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }()
    
    public override init() {
        super.init()
        keychain.getObject { [weak self] (token) in
            guard let unwrapToken = token else { return }
            self?.network.headers["token"] = "Bearer \(unwrapToken)"
        }
    }
    
    // MARK: - API
    
    // MARK: - logout
    public func logout() {
        guard let request = network.prepareForRequest(request: LogoutRequest()) else { return }
        keychain.deleteObject()
        let task = session.dataTask(with: request)
        task.resume()
    }
    
    // MARK: - login
    public func login(email: String, password: String) {
        var req = LoginRequest()
        req.jsonBody = [
            "password" : password,
            "email"    : email
        ]
        
        guard let request = network.prepareForRequest(request: req) else { return }
        //prepareCredential(user: email, pass: password)
        let task = session.dataTask(with: request)
        task.resume()
    }
    
    // MARK: - register
    public func register(name: String, email: String, password: String) {
        
        var req = RegisterRequest()
        req.jsonBody = [
            "name"     : name,
            "email"    : email,
            "password" : password
        ]
        guard let request = network.prepareForRequest(request: req) else { return }
        //prepareCredential(user: email, pass: password)
        let task = session.dataTask(with: request)
        task.resume()
    }
    
    // MARK: - register
    public func autoLogin() {
        
        keychain.getObject { [weak self] (token) in
            guard let unwrapToken = token else {
                self?.delegate?.didFinish(error: ErrorFactory.autoLogin())
                return
            }
            self?.network.headers["token"] = "Bearer \(unwrapToken)"
            self?.delegate?.didFinish(error: nil)
        }
    }
    
}

//extension AuthService {
//    private func prepareCredential(user: String, pass: String) {
//        let credential = URLCredential(user: user, password: pass, persistence: .forSession)
//        guard let host = network.urlComponents.host, let scheme = network.urlComponents.scheme else {
//            return
//        }
//        
//        let protectionSpace = URLProtectionSpace(host: host, port: 443, protocol: scheme, realm: nil, authenticationMethod: NSURLAuthenticationMethodHTTPBasic)
//        session.configuration.urlCredentialStorage?.setDefaultCredential(credential, for: protectionSpace)
//    }
//}

//MARK: - URLSessionDelegate
extension AuthService: URLSessionDelegate {
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, nil)
    }
}

//MARK: - URLSessionDataDelegate
extension AuthService: URLSessionDataDelegate {
    
    public func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        DispatchQueue.main.async { [weak self] in
            self?.delegate?.didFinish(error: error)
        }
    }
    
    public func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        guard let _ = dataTask.response as? HTTPURLResponse else { return }
        guard let response = try? JSONDecoder().decode(AuthResponse.self, from: data) else { return }
        keychain.setObject(object: response.data.access_token)
    }
    
}
