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
    private var authSerivce: ManualAuthService?
    var dataSource : [String] {
        return CoreModels.Locale.allCases.map { $0.rawValue }
    }
    
    init() {
        service = SandboxService()
        service?.delegate = self
        
        authSerivce = AuthService()
        authSerivce?.delegate = self
    }
    
    weak var view: LocaleViewProtocol?
    
    func selectRow(index: Int) {
        view?.loading()
        let locale = locales[index]
        service?.getText(for: locale.rawValue)
    }
    
    func logout() {
        view?.loading()
        authSerivce?.logout()
    }
    
}

extension LocalePresenter: AuthServiceDelegate {
    func didLogout() {
        DispatchQueue.main.async { [weak self] in
            self?.view?.finishLoading()
            self?.view?.toLogout()
        }
    }
    
    func didFinish(data: AuthResponse) {}
    
    func didAutoLogin() {}
    
}
 
extension LocalePresenter: SandboxServiceDelegate {
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
    
    func didFinish(data: String) {
        DispatchQueue.main.async { [weak self] in
            self?.view?.finishLoading()
        }
        
        let chs = CharacterSet.init(charactersIn: data).allCharacters()
        var array: [CharSet] = []
        
        for c in chs {
            array.append(CharSet(char: c, count: data.count(of: c)))
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.view?.toOccurance(array: array)
        }
    }
    
}

private extension CharacterSet {
    func allCharacters() -> [Character] {
        var result: [Character] = []
        for plane: UInt8 in 0...16 where self.hasMember(inPlane: plane) {
            for unicode in UInt32(plane) << 16 ..< UInt32(plane + 1) << 16 {
                if let uniChar = UnicodeScalar(unicode), self.contains(uniChar) {
                    result.append(Character(uniChar))
                }
            }
        }
        return result
    }
}

private extension String {
    func count(of needle: Character) -> Int {
        return reduce(0) {
            $1 == needle ? $0 + 1 : $0
        }
    }
}
