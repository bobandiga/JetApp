//
//  LoginPresenter.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import Core
import CoreModels

final class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    private var authManager: ManualAuthService?
    private var loginData = LoginData(email: "", password: "")
    
    init() {
        authManager = AuthService()
        authManager?.delegate = self
    }
    
    func login() {
        view?.loading()
        authManager?.login(email: loginData.email, password: loginData.password)
    }
    
    func email(_ text: String) {
        loginData.email = text
    }
    
    func pass(_ text: String) {
        loginData.password = text
    }
    
}
 
extension LoginPresenter: AuthServiceDelegate {

    
    func didFinish(error: Error) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.finishLoading()
            guard let error = error as? BaseError else {
                self?.view?.showError(title: "Error", message: "Unefined")
                return
            }
            self?.view?.showError(title: error.title, message: error.reason)
        }
    }
    
    func didFinish(data: AuthResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.finishLoading()
            self?.view?.toLocale()
        }
    }
    
    func didAutoLogin() {}
    
    func didLogout() {}
    
}
