//
//  SignupInterface.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

protocol SignupViewProtocol: class {
    func loading()
    func finishLoading()
}

protocol SignupPresenterProtocol: class {
    var view: SignupViewProtocol? { get set }
    func register()
    
    func name(_ text: String)
    func email(_ text: String)
    func pass(_ text: String)
}
