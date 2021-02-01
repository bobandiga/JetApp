//
//  LocalePresenter.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import Foundation
import CoreModels
import Core

final class LocalePresenter: LocalePresenterProtocol {
    
    private lazy var locales = CoreModels.Locale.allCases
    private lazy var service: SandboxServiceProtocol = SandboxService()
    
    var dataSource : [String] {
        return CoreModels.Locale.allCases.map { $0.rawValue }
    }
    
    weak var view: LocaleViewProtocol?
    
    func selectRow(index: Int) {
        
    }
}
