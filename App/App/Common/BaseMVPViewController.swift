//
//  BaseMVPViewController.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit



public class BaseMVPViewController<Presenter, View: UIView>: UIViewController {
    
    var presenter: Presenter?
    lazy var customView: View = View()
    
    override public func loadView() {
        view = customView
    }
    
    func showError(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    lazy var loaderView: ProgressHUD = ProgressHUD()
}
