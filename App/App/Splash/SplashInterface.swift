//
//  SplashInterface.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

protocol SplashViewProtocol: class {
    func loading()
    func finishLoading()
    func toAuth()
}

protocol SplashPresenterProtocol: class {
    var view: SplashViewProtocol? { get set }
    func autoLogin()
}
