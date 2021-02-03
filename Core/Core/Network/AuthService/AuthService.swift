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
    func didFinish(error: Error)
    func didFinish(data: AuthResponse)
    func didAutoLogin()
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
    private let keychain = AuthKeychain()
    private lazy var requestFactory : RequestFactory = {
        var components = URLComponents.create(scheme: .https, host: "apiecho.cf")
        components.path = "/api"
        let headers = ["Content-type":"application/json"]
        let reqF =  CoreRequestFactory(urlComponents: components, headers: headers)
        return reqF
    }()
    
    // MARK: - API
    public func logout() {
        
        keychain.deleteObject()
        let req = LogoutRequest()
        guard let urlRequest = requestFactory.prepareRequest(req) else { return }
        let session = CoreSessionFactory.prepareSharedSession(sessionDelegate: nil, delegateQueue: nil)
        let task = SimpleTask({ [weak self] (d, r, e) in
            self?.handleResponse(data: d, response: r, error: e)
        }).prepareTask(session: session, request: urlRequest)
        task.resume()

    }
    
    public func login(email: String, password: String) {
        var req = LoginRequest()
        req.jsonBody = [
            "password" : password,
            "email"    : email
        ]
        guard let urlRequest = requestFactory.prepareRequest(req) else { return }
        let session = CoreSessionFactory.prepareSharedSession(sessionDelegate: nil, delegateQueue: nil)
        let task = SimpleTask({ [weak self] (d, r, e) in
            self?.handleResponse(data: d, response: r, error: e)
        }).prepareTask(session: session, request: urlRequest)
        task.resume()
    }
    
    public func register(name: String, email: String, password: String) {
        
        var req = RegisterRequest()
        req.jsonBody = [
            "name"     : name,
            "email"    : email,
            "password" : password
        ]
        guard let urlRequest = requestFactory.prepareRequest(req) else { return }
        let session = CoreSessionFactory.prepareSharedSession(sessionDelegate: nil, delegateQueue: nil)
        let task = SimpleTask({ [weak self] (d, r, e) in
            self?.handleResponse(data: d, response: r, error: e)
        }).prepareTask(session: session, request: urlRequest)
        task.resume()
    }
    
    public func autoLogin() {
        guard let _ = keychain.getObject() else {
            delegate?.didFinish(error: AutoLogin())
            return
        }
        delegate?.didAutoLogin()
    }
    
}

extension AuthService {
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
        guard let data = data else {
            delegate?.didFinish(error: DataError())
            return
        }
        guard let authR = try? JSONDecoder().decode(AuthResponse.self, from: data) else { return }
        keychain.setObject(object: authR.data.access_token)
        delegate?.didFinish(data: authR)
    }
}
