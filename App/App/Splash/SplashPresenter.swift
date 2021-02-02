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
        
        view?.toAuth()
        view?.loading()
        authManager?.autoLogin()
    }
    
}

extension SplashPresenter: AuthServiceDelegate {
    func didFinish(error: Error?) {
        if let _ = error {
            view?.toAuth()
            return
        }
        view?.finishLoading()
    }
    
}
