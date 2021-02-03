//
//  SplashPresenter.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import Core

final class SplashPresenter: SplashPresenterProtocol {
    private var authManager: AutoAuthService?
    weak var view: SplashViewProtocol?
    
    init() {
        authManager = AuthService()
        authManager?.delegate = self
    }
    
    func autoLogin() {
        view?.loading()
        authManager?.autoLogin()
    }
    
}

extension SplashPresenter: AuthServiceDelegate {

    
    func didFinish(error: Error) {
        view?.finishLoading()
        view?.toAuth()
    }
    
    func didFinish(data: AuthResponse) {}
    func didLogout() {}
    
    func didAutoLogin() {
        view?.finishLoading()
        view?.toLocale()
    }
    
}
