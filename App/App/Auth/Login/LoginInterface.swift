//
//  LoginInterface.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

protocol LoginViewProtocol: class {
    func loading()
    func finishLoading()
    func showError(title: String, message: String)
    func toLocale()
}

protocol LoginPresenterProtocol: class {
    var view: LoginViewProtocol? { get set }
    func login()
    
    func email(_ text: String)
    func pass(_ text: String)
}
