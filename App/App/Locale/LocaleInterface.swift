//
//  LocaleInterface.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation

protocol LocaleViewProtocol: class {
    
}

protocol LocalePresenterProtocol: class {
    var dataSource: [String] { get }
    var view: LocaleViewProtocol? { get set }
    func selectRow(index: Int)
}
