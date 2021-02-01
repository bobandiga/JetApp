//
//  SplashView.swift
//  App
//
//  Created by Максим Шаптала on 01.02.2021.
//

import UIKit
 
final class SplashView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
