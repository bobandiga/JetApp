//
//  SignupPresenter.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import Core
import CoreModels

final class SignupPresenter: SignupPresenterProtocol {
    
    weak var view: SignupViewProtocol?
    private var authManager: ManualAuthService?
    
    private var signupData = SignupData(name: "", email: "", password: "")
    
    init() {
        authManager = AuthService()
        authManager?.delegate = self
    }
    
    func register() {
        view?.loading()
        authManager?.register(name: signupData.name, email: signupData.email, password: signupData.password)
    }
    
    func name(_ text: String) {
        signupData.name = text
    }
    
    func email(_ text: String) {
        signupData.email = text
    }
    
    func pass(_ text: String) {
        signupData.password = text
    }
    
}

extension SignupPresenter: AuthServiceDelegate {
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
    
}
