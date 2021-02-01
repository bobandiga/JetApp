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
    
    lazy var loaderView: ProgressHUD = ProgressHUD()
}
