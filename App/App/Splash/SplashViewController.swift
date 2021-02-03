//
//  ViewController.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit
import Core

final class SplashViewController: BaseMVPViewController<SplashPresenterProtocol, SplashView> {

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter = SplashPresenter()
        presenter?.view = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter?.autoLogin()
    }

}

extension SplashViewController: SplashViewProtocol {
    func toLocale() {
        let vc = LocaleViewController()
        let nav = UINavigationController(rootViewController: vc)
        nav.modalPresentationStyle = .currentContext
        self.present(nav, animated: true, completion: nil)
    }
    
    func toAuth() {
        let viewController = LoginViewController()
        viewController.modalPresentationStyle = .currentContext
        self.present(viewController, animated: true, completion: nil)
    }
    
    func loading() {
        loaderView.show(customView)
    }
    
    func finishLoading() {
        loaderView.hide()
    }
}
