//
//  LocaleInterface.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreModels

protocol LocaleViewProtocol: class {
    func loading()
    func finishLoading()
    func showError(title: String, message: String)
    func toOccurance(array: [CharSet])
    func toLogout()
}

protocol LocalePresenterProtocol: class {
    var dataSource: [String] { get }
    var view: LocaleViewProtocol? { get set }
    func selectRow(index: Int)
    func logout()
}
