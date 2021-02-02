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
    
    private lazy var locales = CoreModels.Locale.allCases.lazy
    private var service: SandboxServiceProtocol?
    
    init() {
        service = SandboxService()
        service?.delegate = self
    }
    
    var dataSource : [String] {
        return CoreModels.Locale.allCases.map { $0.rawValue }
    }
    
    weak var view: LocaleViewProtocol?
    
    func selectRow(index: Int) {
        let locale = locales[index]
        service?.getText(for: locale.rawValue)
    }
}
 
extension LocalePresenter: SandboxServiceDelegate {
    func didFinish(error: Error?) {
        #if DEBUG
        print(error)
        #endif
        view?.finishLoading()
    }
    
}
