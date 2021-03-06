//
//  SignupViewController.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

final class SignupViewController: BaseScrollViewController<SignupPresenterProtocol, SignupView> {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView
            .setNameSelector(#selector(nameTFHandle(_:)))
            .setEmailSelector(#selector(emailTFHandle(_:)))
            .setPassSelector(#selector(passTFHandle(_:)))
            .setSignupSelector(#selector(signupHandle))
        
        presenter = SignupPresenter()
        presenter?.view = self
    }
    
}

private extension SignupViewController {
    @objc func nameTFHandle(_ textField: UITextField) {
        presenter?.name(textField.text ?? "")
    }
    
    @objc func emailTFHandle(_ textField: UITextField) {
        presenter?.email(textField.text ?? "")
    }
    
    @objc func passTFHandle(_ textField: UITextField) {
        presenter?.pass(textField.text ?? "")
    }
    
    @objc func signupHandle() {
        presenter?.register()
    }
}

extension SignupViewController: SignupViewProtocol {
    func toLocale() {
        let vc = LocaleViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .currentContext
        self.present(nav, animated: true, completion: nil)
    }
    
    func loading() {
        loaderView.show(customView)
    }
    
    func finishLoading() {
        loaderView.hide()
    }
    
}
