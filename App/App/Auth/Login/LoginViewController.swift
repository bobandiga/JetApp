//
//  LoginViewController.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit

final class LoginViewController: BaseScrollViewController<LoginPresenterProtocol, LoginView> {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView
            .setEmailSelector(#selector(emailTFHandle(_:)))
            .setPassSelector(#selector(passTFHandle(_:)))
            .setSignupSelector(#selector(signupHandle))
            .setRegisterSelector(#selector(registerHandle))
        
        presenter = LoginPresenter()
        presenter?.view = self
    }
    
}

private extension LoginViewController {
    
    
    @objc func emailTFHandle(_ textField: UITextField) {
        presenter?.email(textField.text ?? "")
    }
    
    @objc func passTFHandle(_ textField: UITextField) {
        presenter?.pass(textField.text ?? "")
    }
    
    @objc func signupHandle() {
        presenter?.login()
    }
    
    @objc func registerHandle() {
        let viewController = SignupViewController()
        present(viewController, animated: true, completion: nil)
    }
    
}

extension LoginViewController: LoginViewProtocol {
    func loading() {
        loaderView.show(customView)
    }
    
    func finishLoading() {
        loaderView.hide()
        DispatchQueue.main.async { [unowned self] in
            let vc = LocaleViewController()
            self.present(vc, animated: true, completion: nil)
        }
    }
}
